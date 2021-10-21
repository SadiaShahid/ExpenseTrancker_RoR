class WalletPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    false
  end

  def create?
    false
  end

  def edit?
    update?
  end

  def update?
    return true if user.present? && user == wallet.user
  end

  # def destroy?
  #   return true if user.present? && user == wallet.user
  # end

  private
 
  def wallet
    record
  end
end
