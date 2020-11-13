class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :item_variant

  validates :item_variant, uniqueness: { scope: :cart }
end
