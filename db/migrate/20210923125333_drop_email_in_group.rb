class DropEmailInGroup < ActiveRecord::Migration[6.1]
  def change
    remove_column :groups, :email, :string

  end
end
