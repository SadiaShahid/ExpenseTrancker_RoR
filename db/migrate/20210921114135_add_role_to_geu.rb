class AddRoleToGeu < ActiveRecord::Migration[6.1]
  def change
    add_column :group_expense_users, :role, :string
  end
end
