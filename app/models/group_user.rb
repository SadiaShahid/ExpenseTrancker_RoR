class GroupUser < ApplicationRecord
  belongs_to :user
  belongs_to :group
  
  attribute :email, :string  # this virtual attribute will help us look the user for invite
  # accepts_nested_attributes_for :group_expense
  before_validation :set_user_id, if: :email?
  validates_uniqueness_of :user_id, :scope => [:group_id]
  def set_user_id
    self.user = User.invite!(email: email)
                
  end
  
end
