class Property < ApplicationRecord
  validates :owner, presence: true
  has_many :proposals
  has_many :price_ranges
  belongs_to :property_type

  def is_available?( start_date, end_date )
    proposals.where(accepted: true).where.not( 'start_date >= ? and end_date <= ?', start_date, end_date ).empty?
  end

end
