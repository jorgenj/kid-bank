class Journal < ActiveRecord::Base
  has_many :postings

  validates :transaction_type, 
    presence: true,
    inclusion: { in: %w(DEPOSIT WITHDRAWAL TRANSFER) }

  #TODO: validate sum total of all postings nets to zero
  #TODO: validate postings count > 0
  
  def self.deposit!(account, amount)
    transfer!(Account.cash_account, account, amount, 'DEPOSIT')
  end

  def self.withdraw!(account, amount)
    transfer!(account, Account.cash_account, amount, 'WITHDRAWAL')
  end

  def self.transfer!(src_acct, dst_acct, amount, txn_type = 'TRANSFER')
    journal = Journal.create!(transaction_type: txn_type)
    journal.postings.create!(account: src_acct, amount: 0 - amount)
    journal.postings.create!(account: dst_acct, amount: amount)

    journal
  end
end
