class RenameTransaction12 < ActiveRecord::Migration[6.1]
  def change
    rename_column :notifications, :trans, :trans_id

  end
end
