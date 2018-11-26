class Journal < ApplicationRecord
  resourcify

  has_many :postings
  has_one :txn, class_name: 'Transaction'

  validates :transaction_type, 
    presence: true,
    inclusion: { in: %w(DEPOSIT WITHDRAWAL TRANSFER INTEREST) }

  #TODO: validate sum total of all postings nets to zero
  #TODO: validate postings count > 0
  
  def self.deposit!(account, amount, notes = nil)
    raise 'Account must not be nil' if account.nil?
    raise 'Amount must not be nil' if amount.nil?
    raise 'Amount must be greater than 0' unless amount > 0

    transfer!(Account.cash_account!, account, amount, 'DEPOSIT', notes)
  end

  def self.withdraw!(account, amount, notes = nil)
    raise 'Account must not be nil' if account.nil?
    raise 'Amount must not be nil' if amount.nil?
    raise 'Amount must be greater than 0' unless amount > 0

    transfer!(account, Account.cash_account!, amount, 'WITHDRAWAL', notes)
  end

  def self.transfer!(src_acct, dst_acct, amount, txn_type = 'TRANSFER', notes = nil)
    raise 'Source account must not be nil' if src_acct.nil?
    raise 'Destination account must not be nil' if dst_acct.nil?
    raise 'Amount must not be nil' if amount.nil?
    raise 'Amount must be greater than 0' unless amount > 0
    raise 'txn_type must not be nil' if txn_type.nil?

    journal = Journal.create!(transaction_type: txn_type, notes: notes)
    journal.postings.create!(account: src_acct, amount: 0 - amount)
    journal.postings.create!(account: dst_acct, amount: amount)

    journal
  end
end
