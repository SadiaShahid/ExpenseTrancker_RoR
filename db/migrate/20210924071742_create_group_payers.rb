class CreateGroupPayers < ActiveRecord::Migration[6.1]
  def change
    create_table :group_payers do |t|
      t.integer :group_expense_id
      t.integer :user_id
      t.float :lent, default: 0
      t.float :borrow, default: 0

      t.timestamps
    end
  end
end
