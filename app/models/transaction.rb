class Transaction < ActiveRecord::Base
  resourcify

  belongs_to :account
  belongs_to :journal

  before_validation :capture_balances, if: :new_record?
  before_create :record_journal, if: :new_record?

  validates :account, presence: true

  ## generated after validation, so can't check this during validation
  #validates :journal, presence: true

  validates :transaction_type, 
    presence: true, 
    inclusion: { in: %w(DEPOSIT WITHDRAWAL) }
  
  validates :note, 
    presence: true, 
    length: { minimum: 1, maximum: 255 }

  validates :amount, presence: true, numericality: true
  validates :start_balance, presence: true, numericality: true
  validates :end_balance, presence: true, numericality: true

  def deposit?
    transaction_type.try(:upcase).try(:eql?, 'DEPOSIT')
  end

  def withdrawal?
    transaction_type.try(:upcase).try(:eql?, 'WITHDRAWAL')
  end

  private

  def record_journal
    if deposit?
      self.journal = Journal.deposit!(account, amount)
    elsif withdrawal?
      self.journal = Journal.withdraw!(account, amount)
    else
      raise "Unknown transaction type: #{transaction_type}"
    end
  end

  def capture_balances
    return unless account.present? && amount.present?

    self.start_balance = account.postings(true).sum(:amount)
    if deposit?
      self.end_balance = self.start_balance + amount
    else
      self.end_balance = self.start_balance - amount
    end
  end
end
