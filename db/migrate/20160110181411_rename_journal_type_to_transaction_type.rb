class RenameJournalTypeToTransactionType < ActiveRecord::Migration
  def change
    rename_column :journals, :type, :transaction_type
  end
end
