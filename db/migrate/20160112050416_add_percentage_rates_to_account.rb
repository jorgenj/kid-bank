class AddPercentageRatesToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :daily_percentage_rate, :decimal
    add_column :accounts, :weekly_percentage_rate, :decimal
    add_column :accounts, :annual_percentage_rate, :decimal
  end
end
