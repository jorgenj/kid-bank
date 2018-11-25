class DividendManager
  def self.add_missing_accruals(date = Date.yesterday)
    unless date < Date.today
      Rails.logger.warn "Skipping interest accruals, #{date} is not in the past yet"
      return
    end

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
            amount: account.balance * account.dpy,
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
    unless date.sunday?
      Rails.logger.warn "Skipping applying earnings for #{date}, #{Date::DAYNAMES[date.wday]} not a sunday!"
      return
    end
    unless date < Date.today
      Rails.logger.warn "Skipping apply earnings for #{date}, it's not in the past yet!"
      return
    end

    interest_src_account = Account.interest_account!

    prev_sunday = date - 7.days

    Account.user_accounts.find_each do |account|
      Rails.logger.info "Applying earnings from #{prev_sunday} to #{date} for #{account.inspect}"
      begin
        ActiveRecord::Base.transaction do
          accruals = InterestAccrual.where(account: account)
            .where(applied: false)
            .where('accrued_on > ? AND accrued_on <= ?', prev_sunday, date)

          next if accruals.empty?

          earnings = accruals.sum(:amount)

          accruals.update_all(applied: true, applied_at: Time.now)
          Rails.logger.info "Earnings of #{earnings} to apply for #{account.inspect}"

          if earnings > 0
            Journal.transfer!(interest_src_account, account, earnings, 'INTEREST', "Interest accrued - #{date.to_date}")
          else
            Rails.logger.info "Skipped applying #{earnings} to #{account.inspect}"
          end
        end
      rescue => e
        Rails.logger.fatal "Failed to transfer interest to account : #{account.inspect} : #{e.message}"
        e.backtrace.each { |line| Rails.logger.error line }
      end
    end
  end
end
