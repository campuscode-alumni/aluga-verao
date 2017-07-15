class PropertyType < ApplicationRecord
  validates :name, presence: { message: 'Você deve preencher o nome do tipo de imóvel' }
  has_many :properties
end
