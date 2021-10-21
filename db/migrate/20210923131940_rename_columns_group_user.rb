class RenameColumnsGroupUser < ActiveRecord::Migration[6.1]
  def change
    rename_column :group_users, :u_id, :user_id
    rename_column :group_users, :g_id, :group_id
  end
end
