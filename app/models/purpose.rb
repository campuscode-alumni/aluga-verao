class Purpose < ApplicationRecord
  has_many :property_purposes
  has_many :properties, through: :property_purposes
end
