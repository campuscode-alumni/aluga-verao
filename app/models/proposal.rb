class Proposal < ApplicationRecord
  validates :start_date, :end_date, :total_guests, :name, :email, :cpf,
            :phone, :observation, presence: true
  belongs_to :property

  after_validation :calculate_total_amount

  private

  def check_start_date?
    unless start_date.nil?
      if start_date <= Date.today
        errors.add(:base, 'Data inicial deve ser maior do que a data de hoje')
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

  def check_minimum_rent?(days)
    if days < property.minimun_rent
      errors.add(:base, "Quantidade de dias para hospedagem precisa ser maior que #{property.minimun_rent}")
      return false
    end
    true
  end

  def check_maximum_rent?(days)
    if days > property.maximum_rent
      errors.add(:base, "Quantidade de dias para hospedagem precisa ser menor que #{property.maximum_rent}")
      return false
    end
    true
  end

  def calculate_total_amount
    if check_start_date? and check_end_date?
      days = (end_date - start_date).to_i
      if check_minimum_rent?(days) and check_maximum_rent?(days)
        self.total_amount = (property.daily_rate * days).to_f
      end
    end
  end
end
