class InterestAccrual < ActiveRecord::Base
  resourcify

  belongs_to :account

  validates :account_id, presence: true
  validates :accrued_on, presence: true
  validates :amount, presence: true
  validates :account_end_balance, presence: true
end
