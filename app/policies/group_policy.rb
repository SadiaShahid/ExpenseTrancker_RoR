class GroupPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    false
  end

  def create?
    return true if user.present? 
  end
  def show?
    return true if user.present? && user.id == group.group_users.find_by(user_id: user.id).user_id
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
  
  def group
    record
  end
end
  