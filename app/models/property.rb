class Property < ApplicationRecord
  validates :owner, presence: true
end
