class Customer < ApplicationRecord
  has_many :orders
  has_one :cart

  validates :name, :email, :password, presence: true
end
