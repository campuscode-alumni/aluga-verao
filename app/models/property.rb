class Property < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  has_many :proposals
  has_many :price_ranges
  has_many :property_purposes
  has_many :purposes , through: :property_purposes
  belongs_to :property_type
  has_many :property_reviews
  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/

  def is_available?( start_date, end_date )
    proposals.find_by_sql([' select * from proposals where accepted = :accept and (start_date >= :start_param) and (:end_param >= start_date) or (end_date >= :start_param) and (start_date < :end_param) ', { accept: true, start_param: start_date, end_param: end_date}]).empty?
  end

  def has_review_from?(user)
    property_reviews.where(user: user).any?
  end

end
