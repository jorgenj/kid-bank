class AddInterestAccrual < ActiveRecord::Migration
  def change
    create_table :interest_accruals do |t|
      t.belongs_to :account
      t.date       :accrued_on
      t.integer    :amount
      t.integer    :account_end_balance

      t.timestamps null: false
    end
  end
end
