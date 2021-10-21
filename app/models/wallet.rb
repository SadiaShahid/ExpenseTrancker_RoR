class Wallet < ApplicationRecord
  belongs_to  :user
  has_many :transactions, as: :transactionable
end
