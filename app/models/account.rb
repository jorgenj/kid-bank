class Account < ActiveRecord::Base
  # double-entry book-keeping design based on this article:
  # http://web.archive.org/web/20131013080026/http://homepages.tcp.co.uk/~m-wigley/gc_wp_ded.html

  has_many :postings
  has_many :transactions

  def self.user_accounts
    where(arel_table[:id].not_in(1))
  end

  ## TODO: cache on updates to postings
  def balance
    postings.sum(:amount)
  end

  def self.cash_account
    find(1)
  end
end
