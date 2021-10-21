class ChangeAccountDtype < ActiveRecord::Migration[6.1]
  def change
    remove_column :bank_accounts, :acc_no
    add_column :bank_accounts, :acc_no, :bigint
  end
end
