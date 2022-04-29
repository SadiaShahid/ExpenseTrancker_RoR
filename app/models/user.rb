class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :wallet
  has_many :bank_accounts
  has_many :transactions
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :notifications
  
  after_create do |user|
    user.create_wallet
  end
  # def generate_jwt
  # JWT.encode({ id: id,
  #             exp: 60.days.from_now.to_i },
  #            Rails.application.secrets.secret_key_base)
  # end
end
