class ChangesIn < ActiveRecord::Migration[6.1]
  def change
    add_column :group_expenses, :user_id, :integer
    rename_column :group_payers, :user_id, :lenter_id
    add_column :group_payers, :borrower_id, :integer
    
  end
end
