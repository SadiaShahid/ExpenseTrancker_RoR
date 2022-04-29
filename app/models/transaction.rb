class Transaction < ApplicationRecord 
  validates_presence_of :date
  validates :amount, presence:true, numericality: { greater_than: 1.0 }
  belongs_to :user
  belongs_to :transactionable, polymorphic: true
  has_many :notifications
  enum category: {
      Food: 0,
      Transportation: 1,
      Tax: 2,
      Accomodation: 3,
      
    }


end
