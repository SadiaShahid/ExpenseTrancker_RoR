module BankAccountsHelper
    def account_meta bank_account    
        "Bank Name: #{ bank_account.bank_name } \n User Name: #{ current_user.name }"
    end
end
