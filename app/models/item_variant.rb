class ItemVariant < ApplicationRecord
  belongs_to :item
  belongs_to :variant

  validates :image, presence: true
end
