class Posting < ActiveRecord::Base
  resourcify

  belongs_to :account
  belongs_to :journal

  validates :amount, 
    presence: true, 
    numericality: true

  validates :account_id,
    presence: true

  validates :journal_id,
    presence: true
end
