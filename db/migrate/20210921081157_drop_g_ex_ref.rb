class DropGExRef < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :group_expense_id, :bigint
    add_column :users, :group_expense_id, :bigint
  end
end
