class AddAppliedToInterestAccruals < ActiveRecord::Migration
  def change
    add_column :interest_accruals, :applied, :boolean
  end
end
