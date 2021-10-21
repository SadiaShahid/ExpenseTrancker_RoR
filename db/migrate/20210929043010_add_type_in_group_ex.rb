class AddTypeInGroupEx < ActiveRecord::Migration[6.1]
  def change
    add_column :group_expenses, :type, :string

  end
end
