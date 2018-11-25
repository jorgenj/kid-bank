class Account < ApplicationRecord
  resourcify

  # double-entry book-keeping design based on this article:
  # http://web.archive.org/web/20131013080026/http://homepages.tcp.co.uk/~m-wigley/gc_wp_ded.html

  has_many :postings
  has_many :transactions
  has_many :interest_accruals

  belongs_to :user

  before_save :update_balance
  before_save :calc_percentages

  validates :name, presence: true
  validates :user_id, presence: true
  
  def self.user_accounts
    system_account_ids = SystemAccount.all.select(:account_id).arel
    where(arel_table[:id].not_in(system_account_ids))
  end

  scope :without_earnings, ->(date) {
    date = date.to_date if date.respond_to?(:to_date)
    accts_with_earnings = InterestAccrual.where('accrued_on = ?', date).select(:account_id).arel
    where(arel_table[:id].not_in(accts_with_earnings))
  }

  def self.cash_account!
    SystemAccount.cash!.account
  end

  def self.interest_account!
    SystemAccount.interest!.account
  end

  def update_balance
    self.balance = postings.reload.sum(:amount)
  end

  def calc_percentages
    unless annual_percentage_rate.nil?
      self.daily_percentage_rate = annual_percentage_rate / 365
      self.weekly_percentage_rate = daily_percentage_rate * 7
    end
  end

  def dpy
    BigDecimal.new(self.annual_percentage_rate) / (100 * 365)
  end

  def interest_earned(period, principal=self.balance)
    num_days = (period / 1.day).to_i
    rate = (1 + dpy)**num_days
    end_balance = (principal * rate)
    end_balance.to_i - principal
  end
end
