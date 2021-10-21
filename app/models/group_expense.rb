class GroupExpense < ApplicationRecord
  belongs_to :group
  has_many :group_payers
  accepts_nested_attributes_for :group_payers
end
