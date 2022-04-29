class AddTransaction < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :transaction_id, :integer

  end
end
