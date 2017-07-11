class Property < ApplicationRecord
  validates :owner, presence: true

  has_many :proposals
end
