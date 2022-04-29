class RenameTransaction < ActiveRecord::Migration[6.1]
  def change
    rename_column :notifications, :transaction_id, :trans

  end
end
