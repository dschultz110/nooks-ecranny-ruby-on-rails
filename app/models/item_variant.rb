class ItemVariant < ApplicationRecord
  belongs_to :item
  belongs_to :variant

  validates :image, presence: true
  validates :item, uniqueness: { scope: :variant }
end
