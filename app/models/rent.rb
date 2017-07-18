class Rent < ApplicationRecord
  belongs_to :proposal
  has_one :user, through: :proposal
  has_one :property, through: :proposal
end
