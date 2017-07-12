class Property < ApplicationRecord
  validates :owner, presence: true

  has_many :proposals
  has_many :price_ranges
end
