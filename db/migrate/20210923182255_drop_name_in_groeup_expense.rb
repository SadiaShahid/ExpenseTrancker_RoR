class DropNameInGroeupExpense < ActiveRecord::Migration[6.1]
  def change
    remove_column :group_expenses, :name, :string
    add_column :group_expenses, :group_id, :integer
  end
end
