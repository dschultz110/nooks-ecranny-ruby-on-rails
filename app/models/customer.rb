class Customer < ApplicationRecord
  has_many :orders

  validates :name, :email, :password, presence: true
end
