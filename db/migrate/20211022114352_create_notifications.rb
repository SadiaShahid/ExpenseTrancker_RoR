class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.datetime :read_at
      t.string :action
      t.integer :transaction_id

      t.timestamps
    end
  end
end
