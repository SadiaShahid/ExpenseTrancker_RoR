class CreateWallets < ActiveRecord::Migration[6.1]
  def change
    create_table :wallets do |t|
      t.float :credit, default: 0

      t.timestamps
    end
  end
end
