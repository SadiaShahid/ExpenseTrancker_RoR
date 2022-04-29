class Notification < ApplicationRecord
  belongs_to :user 
  belongs_to :trans, class_name: 'Transaction'
  belongs_to :notificationable, polymorphic: true
  scope :unread, -> { where(:read_at => nil)}
  # Ex:- scope :active, -> {where(:active => true)}
end
