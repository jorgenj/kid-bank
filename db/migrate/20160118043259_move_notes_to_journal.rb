class MoveNotesToJournal < ActiveRecord::Migration
  def change
    remove_column :postings, :notes
    add_column :journals, :notes, :text
  end
end
