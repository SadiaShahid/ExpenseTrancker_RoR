class DropBankTransferTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :bank_transfers do |t|
      t.integer :bank_transferable_id
    t.string :bank_transferable_type
    end
  end
end
