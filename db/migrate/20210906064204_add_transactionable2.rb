class AddTransactionable2 < ActiveRecord::Migration[6.1]
  def change
    remove_index :transactions, name: "trans_index"
    add_index :transactions, [:transactionable_id, :transactionable_type], name: "trans_index"
  end
end
