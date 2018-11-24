class Posting < ApplicationRecord
  resourcify

  belongs_to :account
  belongs_to :journal

  before_validation :capture_balances, if: :new_record?
  after_save :update_account_balance

  validates :amount, 
    presence: true, 
    numericality: true

  validates :account_id,
    presence: true

  validates :journal_id,
    presence: true

  private

  def capture_balances
    return unless account.present? && amount.present?

    self.start_balance = account.postings.reload.sum(:amount)
    self.end_balance = self.start_balance + amount
  end

  def update_account_balance
    if account.present?
      ## have to load acct directly/separately
      ## otherwise we get a strange error where
      ## activeRecord would think it still needs to insert the Transaction
      ## that spawned this journal/posting, but would only insert the single
      ## journal_id attribute
      acct = Account.find(account_id)
      acct.update_balance
      acct.save!
    end
  end
end
