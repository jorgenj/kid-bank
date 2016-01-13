class DividendManager
  def self.add_missing_accruals(date = Date.yesterday)
    Account.user_accounts.without_earnings(date).find_each do |account|
      Rails.logger.info "Adding accrual for account : #{account.inspect}"
      begin
        ActiveRecord::Base.transaction do
          ## make sure the account balance is accurate
          account.update_balance
          account.save!

          accrual = account.interest_accruals.create!(
            accrued_on: date,
            account_end_balance: account.balance,
            amount: account.balance * account.daily_percentage_rate,
            applied: false,
          )
          Rails.logger.info "Added accrual : #{accrual.inspect}"
        end
      rescue => e
        Rails.logger.fatal "Failed to accrue interest for account : #{account.inspect} : #{e.message}"
        e.backtrace.each { |line| Rails.logger.error line }
      end
    end
  end

  def self.apply_earnings(date = Date.yesterday)
    return unless date.sunday?
    return unless date < Date.today

    interest_src_account = Account.interest_account

    prev_sunday = date - 7.days

    Account.user_accounts.find_each do |account|
      Rails.logger.info "Applying earnings from #{prev_sunday} to #{date} for #{account.inspect}"
      begin
        ActiveRecord::Base.transaction do
          accruals = InterestAccrual.where(account: account)
            .where(applied: false)
            .where('accrued_on > ? AND accrued_on <= ?', prev_sunday, date)

          earnings = accruals.sum(:amount)
          accruals.update_all(applied: true, applied_at: Time.now)
          Rails.logger.info "Earnings of #{earnings} to apply for #{account.inspect}"

          Journal.transfer!(interest_src_account, account, earnings, 'INTEREST')
        end
      rescue => e
        Rails.logger.fatal "Failed to transfer interest to account : #{account.inspect} : #{e.message}"
        e.backtrace.each { |line| Rails.logger.error line }
      end
    end
  end
end
