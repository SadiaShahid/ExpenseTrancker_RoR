class TransactionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user_id: user.id)
    end
  end

  def index?
    false
  end

  def create?
    false
  end

  def edit?
    false
  end

  def update?
    false
  end

  private
 
  def transaction
    record
  end
end
