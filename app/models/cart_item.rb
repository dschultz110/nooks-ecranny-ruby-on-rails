class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :item_variant
end
