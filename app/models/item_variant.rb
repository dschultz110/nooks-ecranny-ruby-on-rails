class ItemVariant < ApplicationRecord
  belongs_to :item
  belongs_to :variant
  has_many :cart_items
  has_many :carts, through: :cart_items

  validates :image, presence: true
  validates :item, uniqueness: { scope: :variant }
end
