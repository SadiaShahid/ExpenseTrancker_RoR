class AddPolymorphiTypeId < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :transactionable_type, :string
    add_column :transactions, :transactionable_id, :integer
    add_column :transactions, :transfer_from_type, :string
    add_column :transactions, :transfer_from_id, :integer
    add_column :transactions, :transfer_to_type, :string
    add_column :transactions, :transfer_to_id, :integer
  end
end
