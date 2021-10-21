class ChangeTypeInGroupEx < ActiveRecord::Migration[6.1]
  def change
    rename_column :group_expenses, :type, :divided
  end
end
