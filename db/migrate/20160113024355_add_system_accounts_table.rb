class AddSystemAccountsTable < ActiveRecord::Migration
  def change
    create_table :system_accounts do |t|
      t.string :name
      t.belongs_to :account

      t.timestamps null: false
    end
  end
end
