class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transaction, only: %i[ show edit update destroy ]

  def index
    # logger.debug current_user
    @transactions = current_user.transactions.order('created_at DESC')
    @user_accounts = ["Wallet"] + current_user.bank_accounts.map(&:bank_name)
    @transaction = Transaction.new
  end
  def new
    @transaction = Transaction.new
    @transactions = current_user.transactions
    @user_accounts = ["Wallet"] + current_user.bank_accounts.map(&:bank_name)

    # authorize @transaction
  end

  def create
  
    @transaction = Transaction.new(transaction_params)
    # @transaction.user_id = current_user.id
    puts transaction_params
    # debugger
    flag = true
    if @transaction.type == "Income"
      @transaction.transfer_to_type = @transaction.transactionable_type
      if @transaction.transactionable_type == 'Wallet'
        wal = current_user.wallet
        wal.credit += @transaction.amount.to_f
        wal.save
        trans = wal
        @transaction.transfer_to_id = trans.id
      else
        account = current_user.bank_accounts.find_by(bank_name: @transaction.transactionable_type)
        account.balance += @transaction.amount.to_f
        account.save
        @transaction.transfer_to_id = account.id
        trans = account
      end
    elsif @transaction.type == 'Expense'
      @transaction.transfer_from_type = @transaction.transactionable_type
      if @transaction.transactionable_type == 'Wallet'
        wal = current_user.wallet
        if (wal.credit < @transaction.amount.to_f)
          flag = false
        else
          wal.credit -= @transaction.amount.to_f
          wal.save
          trans = wal
          @transaction.transfer_from_id = trans.id
        end
      else
        account = current_user.bank_accounts.find_by(bank_name: @transaction.transactionable_type)
        if (account.balance < @transaction.amount.to_f)
          flag = false
        else
          account.balance -= @transaction.amount.to_f
          account.save
          @transaction.transfer_from_id = account.id
          trans = account
        end
      end
    elsif @transaction.type = 'BankTransfer'
      if @transaction.transfer_from_type == 'Wallet'
        wal = current_user.wallet
        if (wal.credit < @transaction.amount.to_f)
          flag = false
        else
          account = current_user.bank_accounts.find_by(bank_name: @transaction.transfer_to_type)
          @transaction.transfer_from_id = wal.id
          @transaction.transfer_to_id = account.id
          wal.credit -= @transaction.amount.to_f
          wal.save
          account.balance += @transaction.amount.to_f
          account.save
          trans = wal
        end
      elsif @transaction.transfer_to_type == 'Wallet'
        account = current_user.bank_accounts.find_by(bank_name: @transaction.transfer_from_type)
        if (account.balance < @transaction.amount.to_f)
          flag = false
        else
          wal = current_user.wallet
          wal.credit += @transaction.amount.to_f
          wal.save
          account.balance -= @transaction.amount.to_f
          account.save
          @transaction.transfer_to_id = wal.id
          @transaction.transfer_from_id = account.id
          trans = account
        end
      else
        account1 = current_user.bank_accounts.find_by(bank_name: @transaction.transfer_from_type)
        account2 = current_user.bank_accounts.find_by(bank_name: @transaction.transfer_to_type)
        if (account1.balance < @transaction.amount.to_f)
          flag = false
        else
          
          account1.balance -= @transaction.amount.to_f
          account1.save
          account2.balance += @transaction.amount.to_f
          account2.save
          @transaction.transfer_to_id = account2.id
          @transaction.transfer_from_id = account1.id
          trans = account1
        end
      end
    end
      # debugger
    respond_to do |format|
      if flag
        trans.transactions.create(
                  transfer_from_type: @transaction.transfer_from_type,
                  transfer_from_id: @transaction.transfer_from_id,
                  transfer_to_id: @transaction.transfer_to_id,
                  amount: @transaction.amount,
                  date: @transaction.date,
                  user_id: current_user.id, 
                  transfer_to_type: @transaction.transfer_to_type, 
                  type: @transaction.type,
                  category: @transaction.category)
      
        
        flash[:notice] = "Transaction successful!"
        Notification.create(user_id: current_user.id, action: 'created', notificationable: @transaction, trans: trans.transactions.last) 
        
        # format.html { redirect_to transfer_path, notice: "Transaction successful!" }
        # render json: {status: 200}
        # end
      else
        flash[:alert] = "You don't have enough money!"
        redirect_to root_path
      end
    end
  end
  def destroy
    if @transaction.type == "Expense"
      if @transaction.transactionable_type == "Wallet"
        current_user.wallet.credit = current_user.wallet.credit +  
        @transaction.amount
        current_user.wallet.save
        # byebug
      elsif @transaction.transactionable_type == "BankAccount"

        @accountbal = BankAccount.find(@transaction.transfer_from_id)
        @accountbal.balance  =@accountbal.balance  + @transaction.amount
        @accountbal.save
      end
    elsif @transaction.type == "Income"
      if @transaction.transactionable_type == "Wallet"
        current_user.wallet.credit = current_user.wallet.credit -  @transaction.amount
        current_user.wallet.save
        # byebug
      elsif @transaction.transactionable_type == "BankAccount"
        @accountbal = BankAccount.find(@transaction.transfer_to_id)
        @accountbal.balance  =@accountbal.balance  - @transaction.amount
        @accountbal.save
      end
    elsif @transaction.type == "BankTransfer"
      if @transaction.transactionable_type == "Wallet"
        @accountbal = BankAccount.find(@transaction.transfer_to_id)
        @accountbal.balance  =@accountbal.balance  - @transaction.amount
        current_user.wallet.credit = current_user.wallet.credit + @transaction.amount
        @accountbal.save
        current_user.wallet.save
      elsif @transaction.transactionable_type == "BankAccount" && @transaction.transfer_to_type=='Wallet'
        @accountbal = BankAccount.find(@transaction.transfer_from_id)
        current_user.wallet.credit = current_user.wallet.credit - @transaction.amount
        @accountbal.balance  =@accountbal.balance  + @transaction.amount
        @accountbal.save
        current_user.wallet.save
      else
        @accountbal1 = BankAccount.find(@transaction.transfer_from_id)
        @accountbal2 = BankAccount.find(@transaction.transfer_to_id)
        @accountbal1.balance  =@accountbal1.balance  + @transaction.amount
        @accountbal2.balance  =@accountbal2.balance  - @transaction.amount
        @accountbal1.save
        @accountbal2.save        
      end
    end
    @transaction.destroy
    # byebug
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Transaction was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  def ajax_create
    @transaction = Transaction.new(transaction_params)
    flag = true
    if @transaction.type == "Income"
      @transaction.category = nil
      @transaction.transfer_from_type = '--'
      @transaction.transfer_from_id = nil
      @transaction.transfer_to_type = @transaction.transactionable_type
      if @transaction.transactionable_type == 'Wallet'
        wal = current_user.wallet
        wal.credit += @transaction.amount.to_f
        wal.save
        trans = wal
        @transaction.transfer_to_id = trans.id
      else
        account = current_user.bank_accounts.find_by(bank_name: @transaction.transactionable_type)
        account.balance += @transaction.amount.to_f
        account.save
        @transaction.transfer_to_id = account.id
        trans = account
      end
    elsif @transaction.type == 'Expense'
      @transaction.transfer_to_type = '--'
      @transaction.transfer_to_id = nil
      @transaction.transfer_from_type = @transaction.transactionable_type
      if @transaction.transactionable_type == 'Wallet'
        wal = current_user.wallet
        if (wal.credit < @transaction.amount.to_f)
          flag = false
        
        else
          wal.credit -= @transaction.amount.to_f
          wal.save
          trans = wal
          @transaction.transfer_from_id = trans.id
        end
      else
        account = current_user.bank_accounts.find_by(bank_name: @transaction.transactionable_type)
        if (account.balance < @transaction.amount.to_f)
          flag = false
        else
          
          account.balance -= @transaction.amount.to_f
          account.save
          @transaction.transfer_from_id = account.id
          trans = account
        end
      end
    elsif @transaction.type = 'BankTransfer'
      @transaction.category =  nil
      if @transaction.transfer_from_type == 'Wallet'
        wal = current_user.wallet
        if (wal.credit < @transaction.amount.to_f)
          flag = false
        else
          account = current_user.bank_accounts.find_by(bank_name: @transaction.transfer_to_type)
          @transaction.transfer_from_id = wal.id
          @transaction.transfer_to_id = account.id
          wal.credit -= @transaction.amount.to_f
          wal.save
          account.balance += @transaction.amount.to_f
          account.save
          trans = wal
        end
      elsif @transaction.transfer_to_type == 'Wallet'
        account = current_user.bank_accounts.find_by(bank_name: @transaction.transfer_from_type)
        if (account.balance < @transaction.amount.to_f)
          flag = false
        else
          wal = current_user.wallet
          wal.credit += @transaction.amount.to_f
          wal.save
          account.balance -= @transaction.amount.to_f
          account.save
          @transaction.transfer_to_id = wal.id
          @transaction.transfer_from_id = account.id
          trans = account
        end
      else
        account1 = current_user.bank_accounts.find_by(bank_name: @transaction.transfer_from_type)
        account2 = current_user.bank_accounts.find_by(bank_name: @transaction.transfer_to_type)
        if (account1.balance < @transaction.amount.to_f)
          flag = false
        else
          
          account1.balance -= @transaction.amount.to_f
          account1.save
          account2.balance += @transaction.amount.to_f
          account2.save
          @transaction.transfer_to_id = account2.id
          @transaction.transfer_from_id = account1.id
          trans = account1
        end
      end
    end
      # debugger
      if flag
      trans.transactions.create(
                transfer_from_type: @transaction.transfer_from_type,
                transfer_from_id: @transaction.transfer_from_id,
                transfer_to_id: @transaction.transfer_to_id,
                amount: @transaction.amount,
                date: @transaction.date,
                user_id: current_user.id, 
                transfer_to_type: @transaction.transfer_to_type, 
                type: @transaction.type,
                category: @transaction.category)
      
        flash[:notice] = "Transaction successful!"
        Notification.create(user_id: current_user.id, action: 'created', notificationable: @transaction, trans: trans.transactions.last)        
      else
        flash[:alert] = "You don't have enough money!"
        redirect_to root_path
      end
    
  end
  private
    
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    def transaction_params
      params.require(:transaction).permit(:date, :amount, :category, :type, :transfer_from_type, :transfer_from_id, :transfer_to_id, :transfer_to_type, :transactionable_id, :transactionable_type)
    end

    # def start_time
    #   self.transaction.date 
    # end
end
