class BankAccount < ApplicationRecord
  validates :bank_name, presence:true, uniqueness: { scope: [ :user_id ]}
  validates :acc_no, presence:true, length: { is: 11 }, uniqueness: true
  validates :balance, presence:true
  belongs_to :user
  has_many :transactions, as: :transactionable
end
