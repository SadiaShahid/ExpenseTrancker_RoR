class CreateBankAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :bank_accounts do |t|
      t.string :bank_name
      t.integer :acc_no
      t.float :balance, default:0

      t.timestamps
    end
  end
end
