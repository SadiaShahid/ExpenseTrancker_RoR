class GroupExpensesController < ApplicationController
  before_action :set_group_expense, only: %i[ edit update destroy show ]

  # GET /group_expenses or /group_expenses.json
  def index
    @group_expenses = GroupExpense.all
  end

  # GET /group_expenses/1 or /group_expenses/1.json
  def show
    @group_expense = GroupExpense.find(params[:id])
    authorize @group_expense
    
  end

  # GET /group_expenses/new
  def new
    
    @group_expense = GroupExpense.new

    @group_expense.group_payers.new
    @group = Group.find(params[:group_id])
    authorize @group_expense

  end

  # GET /group_expenses/1/edit
  def edit
  end

  # POST /group_expenses or /group_expenses.json
  def create
    session[:return_to] ||= request.referer
    h = params[:group_expense][:group_payers_attributes]
    h.each do |key, value|
      if !value.has_key?('user_id')
        params[:group_expense][:group_payers_attributes].delete(key)
      end
    end
    @group_expense = GroupExpense.new(group_expense_params)
    @group_expense.user_id = current_user.id
    if(@group_expense.divided != 'By Percentage')
      @group_expense.group_payers.each do |gp|
        if gp.paid > gp.payable
          gp.lent = gp.paid - gp.payable
        elsif gp.paid < gp.payable
          gp.borrow = gp.payable - gp.paid
        end
      end
    else
      @group_expense.group_payers.each do |gp|  
        gp.paid = (@group_expense.amount*gp.paid)/100
        gp.payable = (@group_expense.amount*gp.payable)/100
        if gp.paid > gp.payable
          gp.lent = gp.paid - gp.payable
        elsif gp.paid < gp.payable
          gp.borrow = gp.payable - gp.paid
        end
      end
    end
    ActiveRecord::Base.transaction do
      if @group_expense.save
        @group_expense.group_payers.each do |gp|
          u = User.find(gp.user_id)
          if(u.wallet.credit < gp.paid )
            flash[:alert]= "Credit of #{u.email} is less than #{gp.paid} . Enter agian." 
            raise ActiveRecord::RangeError
          else
            u.wallet.credit -= gp.paid
            u.wallet.save
            u.wallet.transactions.create(
              transfer_from_type: 'Wallet',
              transfer_from_id: u.wallet.id,
              amount: gp.paid,
              date: DateTime.current.to_date,
              user_id: u.id,
              type: 'Expense')
          end
          
        end
      end
    end
    redirect_to root_path, notice: "Group expense was successfully created." 

  rescue ActiveRecord::RangeError 
    redirect_to session.delete(:return_to)
    

  end

  # PATCH/PUT /group_expenses/1 or /group_expenses/1.json
  def update
    
    session[:return_to] ||= request.referer
    lenters = @group_expense.group_payers.where(borrow: 0)
    borrower = @group_expense.group_payers.find_by(user_id: params[:user_id])
    b = borrower.borrow
    ActiveRecord::Base.transaction do
      u_b = User.find(borrower.user_id)
      # byebug

      if u_b.wallet.credit < borrower.borrow
        flash[:alert]= "Wallet Credit of #{u_b.email} is less than borrowed amount."
        raise ActiveRecord::RangeError
      else
        lenters.each do |l|
          u_l = User.find(l.user_id)
          if borrower.borrow >= l.lent
            borrower.borrow -= l.lent
            u_l.wallet.credit+=l.lent
            u_b.wallet.credit-=l.lent
            l.lent = 0

          elsif borrower.borrow < l.lent
            l.lent-=borrower.borrow
            u_l.wallet.credit+=borrower.borrow
            u_b.wallet.credit-=borrower.borrow
            borrower.borrow = 0
          end
          u_l.wallet.save 
          u_b.wallet.save 
          l.save
          borrower.save
          u_b.wallet.transactions.create(
            transfer_from_type: 'Wallet',
            transfer_from_id: u_b.wallet.id,
            amount: b,
            date: DateTime.current.to_date,
            user_id: u_b.id,
            type: 'Expense')
        end
      end
      @group_expense.save
      
    end
    
    redirect_to root_path, notice: "Settled up Successfully." 

  rescue ActiveRecord::RangeError 
      redirect_to session.delete(:return_to)

      
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_expense
      @group_expense = GroupExpense.find(params[:id])
    end
    # Only allow a list of trusted parameters through.
    def group_expense_params
      params.require(:group_expense).permit(:amount, :group_id, :divided, group_payers_attributes: [:user_id,:payable,:paid])
    end
end
