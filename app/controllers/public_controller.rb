class PublicController < ApplicationController
  before_action :authenticate_user!
  def dashboard
    @bank_accounts = current_user.bank_accounts
    @wallet = current_user.wallet
    @transactions = current_user.transactions
    @transaction = Transaction.new
    @groups = current_user.groups

    grouped_transactions = current_user.transactions.group_by(&:type)
    if !grouped_transactions.empty?
      if grouped_transactions.has_key?("Expense")
        expense = grouped_transactions[Expense.name].map(&:amount).sum
      else
        expense = 0
        
      end
      if grouped_transactions.has_key?("Income")
        income = grouped_transactions[Income.name].map(&:amount).sum
      else
        income=0
      end

      @comparison = {
        expense: expense,
        income: income,
        wallet: current_user.wallet.credit,
        current_balance: current_user.bank_accounts.sum(:balance)
      }
    else
      @comparison = {
        expense: 0, income: 0,
        wallet: current_user.wallet.credit, current_balance: current_user.bank_accounts.sum(:balance)
      }
    end
    @invites = User.all.where(invited_by_id: current_user.id)
    puts current_user.invitation_accepted?
  end    
  def transaction
    @transaction = Transaction.new
    @user_accounts = ["Wallet"] + current_user.bank_accounts.map(&:bank_name)
    @transactions = current_user.transactions

    # @invites = User.where(invited_by_id: current_user.id)
    # byebug
    # start_date = params.fetch(:start_date, Date.today).to_date
    # # byebug
    # @transactions = Transaction.where(starts_at: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
  end

  
  def group_expense
    @invites = Users.where(invited_by_id: current_user.id)
    byebug
  end
end