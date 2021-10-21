class AddTransactionable < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :transactionable_type, :string
    add_column :transactions, :transactionable_id, :integer
    remove_index :transactions, name: "index_transactions_on_transfer_from_id_and_transfer_from_type"
    add_index :transactions, [:transfer_from_id, :transfer_from_type], name: "trans_index"
  end
end
