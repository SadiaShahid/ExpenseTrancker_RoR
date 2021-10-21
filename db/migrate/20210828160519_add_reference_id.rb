class AddReferenceId < ActiveRecord::Migration[6.1]
  def change
    add_reference :wallets, :user
    add_reference :transactions, :user
    add_reference :bank_accounts, :user
    add_reference :users, :wallet

  end
end
