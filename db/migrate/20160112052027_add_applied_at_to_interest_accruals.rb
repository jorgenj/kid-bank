class AddAppliedAtToInterestAccruals < ActiveRecord::Migration
  def change
    add_column :interest_accruals, :applied_at, :timestamp
  end
end
