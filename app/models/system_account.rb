class SystemAccount < ActiveRecord::Base
  resourcify

  belongs_to :account

  validates :name, 
    presence: true, 
    uniqueness: true

  validates :account_id, 
    presence: true

  def self.cash
    find_or_create_by(name: 'CASH') do |new_sys_acct|
      new_sys_acct.account = Account.create(user: first_admin_user, name: new_sys_acct.name)
    end
  end

  def self.interest
    find_or_create_by(name: 'INTEREST') do |new_sys_acct|
      new_sys_acct.account = Account.create(user: first_admin_user, name: new_sys_acct.name)
    end
  end

  private

  def self.first_admin_user
    Role.where(name: 'admin').take.users.first
  end
end
