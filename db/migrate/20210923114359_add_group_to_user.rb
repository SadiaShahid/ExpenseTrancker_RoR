class AddGroupToUser < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :group
  end
end
