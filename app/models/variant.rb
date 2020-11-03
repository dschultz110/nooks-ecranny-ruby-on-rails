class Variant < ApplicationRecord
  has_many :item_variants
  has_many :items, through: :item_variants

  validates :name, presence: true, uniqueness: true
end
