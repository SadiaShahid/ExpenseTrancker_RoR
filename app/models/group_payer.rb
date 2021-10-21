class GroupPayer < ApplicationRecord
  belongs_to :user
  belongs_to :group_expense

  # attribute :email, :string  # this virtual attribute will help us look the user for invite
  # # accepts_nested_attributes_for :group_expense
  # before_validation :set_user_id, if: :email?
  # def set_user_id
  #   existing_user = User.find_by(email: email)
  #   self.user = if existing_user.present?
  #                   existing_user
  #                 else
  #                   User.invite!(email: email)
  #                 end

    

  # end
end
