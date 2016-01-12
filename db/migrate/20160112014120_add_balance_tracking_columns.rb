class AddBalanceTrackingColumns < ActiveRecord::Migration
  def change
    add_column :postings, :start_balance, :integer
    add_column :postings, :end_balance, :integer

    add_column :transactions, :start_balance, :integer
    add_column :transactions, :end_balance, :integer

    add_column :accounts, :balance, :integer
  end
end
