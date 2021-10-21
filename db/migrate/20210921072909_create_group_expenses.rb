class CreateGroupExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :group_expenses do |t|
      t.string :name
      t.float :amount

      t.timestamps
    end
  end
end
