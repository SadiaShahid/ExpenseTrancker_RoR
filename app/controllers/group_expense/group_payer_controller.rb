# class GroupExpense::GroupPayersController < ApplicationController
#   before_action :authenticate_user!
#   before_action :set_group_expense

#   def create
#     group_payer = @group.group_payers.new(group_payer_params)
#     group_payer.group_expense = @group_expense
#     # puts group_expense_user.group_expense
#     # @group_expense.save
#     # byebug
#     if group_payer.save
#       redirect_to @group_expense, notice: "Success"
#     else
#       redirect_to @group_expense, alert: "Member already added"
#     end
#   end

#   # def destroy
#   #   @group_expense.group_expense_users.find(params[:id]).destroy
#   #   # byebug
#   #   redirect_to group_expenses_path, notice: "Member removed"
#   # end

#   private

#   def set_group_expense
    
#     @group_expense = current_user.groups_expenses.find(params[:group_expense_id])
    
#     # if @group_expense.update(group_expense_params)
#     #   # puts group_expense_params
#     #   @group_expense.save
#     # end
#     # @group_expense = current_user.group_expenses.find(params[:group_expense_id])
#     # puts @group_expense

#   end

# #   def group_expense_params
# #     # byebug  
# #     params.require(:group_expense_user).permit(group_expense_attributes: [:name,:amount])
    
# #   end
#   def group_payer_params
#     params.require(:group_payer).permit(:email)
#   end
# end