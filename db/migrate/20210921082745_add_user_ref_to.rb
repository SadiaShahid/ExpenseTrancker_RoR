class AddUserRefTo < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :group_expense_id, :bigint
    add_reference :users, :group_expense

  end
end
