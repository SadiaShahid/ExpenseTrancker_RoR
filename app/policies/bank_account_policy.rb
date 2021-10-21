class BankAccountPolicy < ApplicationPolicy
  #  attr_reader :user, :bank_account

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

  def edit?
    update?
  end

  def update?
    return true if user.present? && user == bank_account.user
  end

  def destroy?
    return true if user.present? && user == bank_account.user
  end

  private
 
  def bank_account
    record
  end

end
