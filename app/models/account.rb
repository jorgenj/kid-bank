class Account < ActiveRecord::Base
  resourcify

  # double-entry book-keeping design based on this article:
  # http://web.archive.org/web/20131013080026/http://homepages.tcp.co.uk/~m-wigley/gc_wp_ded.html

  has_many :postings
  has_many :transactions

  belongs_to :user

  before_save :update_balance

  def self.user_accounts
    where(arel_table[:id].not_in(1))
  end

  validates :name, presence: true
  validates :user_id, presence: true

  def self.cash_account
    find(1)
  end

  def update_balance
    self.balance = postings(true).sum(:amount)
  end
end
