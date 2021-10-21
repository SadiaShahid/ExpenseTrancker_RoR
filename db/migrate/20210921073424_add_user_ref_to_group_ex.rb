class AddUserRefToGroupEx < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :group_expense

  end
end
