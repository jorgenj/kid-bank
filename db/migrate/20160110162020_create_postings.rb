class CreatePostings < ActiveRecord::Migration
  def change
    create_table :postings do |t|
      t.integer :account_id
      t.integer :journal_id
      t.integer :amount

      t.timestamps null: false
    end
  end
end
