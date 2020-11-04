class Type < ApplicationRecord
  has_many :items

  validates :name, presence: true, uniqueness: true

  def to_param
    name
  end
end
