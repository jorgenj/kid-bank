class SystemAccount < ApplicationRecord
  resourcify

  belongs_to :account

  validates :name, 
    presence: true, 
    uniqueness: true

  validates :account_id, 
    presence: true

  def self.cash!
    find_or_create_by!(name: 'CASH') do |new_cash_acct|
      new_cash_acct.account = Account.create(user: User.first_admin, name: new_cash_acct.name)
    end
  end

  def self.interest!
    find_or_create_by!(name: 'INTEREST') do |new_int_acct|
      new_int_acct.account = Account.create(user: User.first_admin, name: new_int_acct.name)
    end
  end
end
