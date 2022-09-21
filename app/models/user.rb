class User < ApplicationRecord
  has_many :post

  validates :email, presence: true
  validates :password, presence: true
end
