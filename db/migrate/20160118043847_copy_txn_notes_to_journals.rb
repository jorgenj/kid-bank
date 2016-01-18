class CopyTxnNotesToJournals < ActiveRecord::Migration
  def change
    Transaction.find_each do |txn|
      journal = txn.journal
      journal.notes = txn.note
      journal.save!
    end
  end
end
