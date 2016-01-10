class Posting < ActiveRecord::Base
  belongs_to :account
  belongs_to :journal

  validates :amount, 
    presence: true, 
    numericality: true
end
