class Order < ApplicationRecord
  belongs_to :customer

  has_many :order_items
  has_many :item_variants, through: :order_items
end
