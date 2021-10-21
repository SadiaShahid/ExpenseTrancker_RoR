class CreateBankTransfers < ActiveRecord::Migration[6.1]
  def change
    create_table :bank_transfers do |t|
      t.integer :bank_transferable_id
      t.string :bank_transferable_type

      t.timestamps
    end
  end
end
