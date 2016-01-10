class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :transaction_type
      t.integer :account_id
      t.integer :amount
      t.integer :journal_id
      t.string :note

      t.timestamps null: false
    end
  end
end
