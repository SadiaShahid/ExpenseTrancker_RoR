class Groups::GroupUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group

  def create
    group_user = @group.group_users.new(group_user_params)
    group_user.group = @group
    # puts group_expense_user.group_expense
    # @group_expense.save
    # byebug
    if group_user.save
      redirect_to @group, notice: "Success"
    else
      redirect_to @group, alert: "Member already added"
    end
  end

  def destroy
    @group.group_users.find(params[:id]).destroy
    # byebug
    redirect_to @group, notice: "Member removed"
  end

  private

  def set_group
   
    @group = current_user.groups.find(params[:group_id])
    
    # if @group_expense.update(group_expense_params)
    #   # puts group_expense_params
    #   @group_expense.save
    # end
    # @group_expense = current_user.group_expenses.find(params[:group_expense_id])
    # puts @group_expense

  end

#   def group_expense_params
#     # byebug  
#     params.require(:group_expense_user).permit(group_expense_attributes: [:name,:amount])
    
#   end
  def group_user_params
    params.require(:group_user).permit(:email)
  end
end