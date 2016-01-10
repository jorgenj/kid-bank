class Journal < ActiveRecord::Base
  has_many :postings

  validates :transaction_type, 
    presence: true,
    inclusion: { in: %w(DEPOSIT WITHDRAWAL TRANSFER) }

  #TODO: validate sum total of all postings nets to zero
  #TODO: validate postings count > 0
end
