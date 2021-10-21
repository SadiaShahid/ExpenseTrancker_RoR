class ChangeTransactionDateDtype < ActiveRecord::Migration[6.1]
  def change
    remove_column :transactions, :date
    add_column :transactions, :date, :date
  end
end
