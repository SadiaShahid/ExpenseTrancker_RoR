class AddColInGroupPayers < ActiveRecord::Migration[6.1]
  def change
    add_column :group_payers, :user_id, :integer
    add_column :group_payers, :payable, :float, default: 0
    add_column :group_payers, :paid, :float, default: 0

  end
end
