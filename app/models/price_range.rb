class PriceRange < ApplicationRecord
  validates :start_date, :end_date, :daily_rate, presence: true
  belongs_to :property

  after_validation :check_start_date?, :check_end_date?, :check_strike?

  private

  def check_strike?
    price_ranges = PriceRange.where('(? between start_date and end_date) or (? between start_date and end_date)', start_date, end_date)

    unless price_ranges.empty?
      if price_ranges.include? self
        return true
      else
        errors.add(:base, 'Já existe um preço personalizado para esse periodo')
        return false
      end
    end
    true
  end

  def check_start_date?
    unless start_date.nil?
      if start_date < Date.today
        errors.add(:base, 'Data inicial deve ser maior ou igual a data de hoje')
        return false
      end
      return true
    end
    false
  end

  def check_end_date?
    unless end_date.nil?
      if start_date > end_date
        errors.add(:base, 'Data final deve ser maior do que a data inicial')
        return false
      end
      return true
    end
    false
  end

end
