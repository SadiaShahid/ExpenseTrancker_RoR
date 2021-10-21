class GroupExpensePolicy < ApplicationPolicy
  class Scope < Scope
    def initialize(user, scope)
      @user  = user
      @group = user_member
    end
    def resolve
      scope.all
    end
  end

  def index?
    false
  end

  def create?
    # group=Group.find(params[:group_id])
    # @group = user_member
    return true if user.present?

    # return true if user.present? 
  end
  def show?
    return true if user.present? 
  end
  def edit?
    false
  end

  def update?
    false
  end

  # def destroy?
  #   return true if user.present? && user == wallet.user
  # end

  private
  def user_member
    # byebug
    @group_members = @group.members
    @group_members.each do |m|
      return true if m.user_id == @user.id
    end
    return false;
  end
  def group_expense
    record
  end
end
  