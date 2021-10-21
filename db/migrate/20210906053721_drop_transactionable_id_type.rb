class DropTransactionableIdType < ActiveRecord::Migration[6.1]
  def change
    remove_column :transactions, :transactionable_id
    remove_column :transactions, :transactionable_type

  end
end
