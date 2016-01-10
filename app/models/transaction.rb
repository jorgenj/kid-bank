class Transaction < ActiveRecord::Base
  belongs_to :account
  belongs_to :journal

  validates :account, presence: true
  validates :journal, presence: true

  validates :transaction_type, 
    presence: true, 
    inclusion: { in: %w(DEPOSIT WITHDRAWAL) }
  
  validates :note, 
    presence: true, 
    length: { minimum: 1, maximum: 255 }

  validates :amount, 
    presence: true, 
    numericality: true
end
