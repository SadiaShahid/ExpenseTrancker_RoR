class NotificationTransaction < ActiveRecord::Migration[6.1]
  def change
    remove_column :notifications, :transaction_id, :integer
    add_column :notifications, :notificationable_id, :integer
    add_column :notifications, :notificationable_type, :string

  end
end
