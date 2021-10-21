class RemoveRef < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :group_expense_id, index: true

  end
end
