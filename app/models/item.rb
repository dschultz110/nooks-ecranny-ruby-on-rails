class Item < ApplicationRecord
  belongs_to :tag
  belongs_to :type
  has_many :item_variants
  has_many :variants, through: :item_variants
  accepts_nested_attributes_for :item_variants, allow_destroy: true

  has_many :order_items
  has_many :orders, through: :order_items

  validates :name, :description, :price, presence: true
  validates :name, uniqueness: true
  validates :price, numericality: { only_integer: true }

  def self.search_by(search_term, type_id)
    if type_id == 0
      where("(LOWER(name) LIKE :search_term OR LOWER(description) LIKE :search_term LIKE :search_term)", search_term: "%#{search_term.downcase}%")
    else
      where("(LOWER(name) LIKE :search_term OR LOWER(description) LIKE :search_term LIKE :search_term) AND type_id == :type_id", type_id: type_id, search_term: "%#{search_term.downcase}%")
    end
  end
end
