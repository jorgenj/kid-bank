class AddNotesToPostings < ActiveRecord::Migration
  def change
    add_column :postings, :notes, :text
  end
end
