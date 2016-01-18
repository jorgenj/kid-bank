class BackfillTxnNotesToPostings < ActiveRecord::Migration
  def change
    Transaction.find_each do |txn|
      txn.journal.postings.update_all(notes: txn.note)
    end
  end
end
