class BackillMissingNotes < ActiveRecord::Migration[5.0]
  def change
    Journal.where(notes: nil).each do |journal|
      txn_note = journal.txn.try(:note)

      if txn_note.present?
        journal.update_attributes!(notes: txn_note)
      end
    end
  end
end
