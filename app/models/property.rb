class Property < ApplicationRecord
  validates :owner, presence: true
  has_many :proposals
  has_many :price_ranges
  belongs_to :property_type

  def is_available?( start_date, end_date )
    proposals.find_by_sql([' select * from proposals where accepted = :accept and (start_date >= :start_param) and (:end_param >= start_date) or (end_date >= :start_param) and (start_date < :end_param) ', { accept: true, start_param: start_date, end_param: end_date}]).empty?
  end

end
