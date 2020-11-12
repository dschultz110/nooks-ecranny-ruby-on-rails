class Cart < ApplicationRecord
  belongs_to :customer, optional: true
  has_many :cart_items
  has_many :item_variants, through: :cart_items
end
