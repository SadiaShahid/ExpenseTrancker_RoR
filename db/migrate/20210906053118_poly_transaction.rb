class PolyTransaction < ActiveRecord::Migration[6.1]
  def change
    # t.belongs_to :transactionable, polymorphic: true

    add_index :transactions, [:transfer_from_id, :transfer_from_type]
  end
end
