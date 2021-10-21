class SetDefaultAmount < ActiveRecord::Migration[6.1]
  def change
    remove_column :group_expenses, :amount
    add_column :group_expenses, :amount, :float, default: 0
  end
end
