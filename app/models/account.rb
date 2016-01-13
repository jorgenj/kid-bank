class Account < ActiveRecord::Base
  resourcify

  # double-entry book-keeping design based on this article:
  # http://web.archive.org/web/20131013080026/http://homepages.tcp.co.uk/~m-wigley/gc_wp_ded.html

  has_many :postings
  has_many :transactions
  has_many :interest_accruals

  belongs_to :user

  before_save :update_balance

  validates :name, presence: true
  validates :user_id, presence: true
  
  def self.user_accounts
    where.not(id: 1).where.not(name: 'INTEREST')
  end

  scope :without_earnings, ->(date) {
    accts_with_earnings = InterestAccrual.where('accrued_on = ?', date).select(:account_id).arel
    where(arel_table[:id].not_in(accts_with_earnings))
  }

  def self.cash_account
    find(1)
  end

  def self.interest_account
    where(name: 'INTEREST').take
  end

  def update_balance
    self.balance = postings(true).sum(:amount)
  end
end
