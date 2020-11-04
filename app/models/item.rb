class Item < ApplicationRecord
  belongs_to :tag
  belongs_to :type
  has_many :item_variants
  has_many :variants, through: :item_variants
  has_many :order_items
  has_many :orders, through: :order_items

  validates :name, :description, :price, presence: true
  validates :name, uniqueness: true
  validates :price, numericality: { only_integer: true }

  def to_param
    name
  end
end
