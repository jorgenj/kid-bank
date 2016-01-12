class Posting < ActiveRecord::Base
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

    self.start_balance = account.postings(true).sum(:amount)
    self.end_balance = self.start_balance + amount
  end

  def update_account_balance
    account.update_balance if account.present?
    account.save!
  end
end
