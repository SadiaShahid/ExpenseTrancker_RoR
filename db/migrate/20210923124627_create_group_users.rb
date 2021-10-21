class CreateGroupUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :group_users do |t|
      t.integer :g_id
      t.integer :u_id
      t.string :role

      t.timestamps
    end
  end
end
