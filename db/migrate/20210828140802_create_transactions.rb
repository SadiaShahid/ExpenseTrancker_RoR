class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.datetime :date
      t.float :amount, default: 0.0
      t.integer :category
      t.string :type

      t.timestamps
    end
  end
end
