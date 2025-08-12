class Expense < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50, message: "maximum of 50 characters only" }
  validates :amount, presence: true, numericality: { greater_than: 0, message: "must be greater than 0" }
  validates :date, presence: true

  validate :date_must_be_valid
  validate :date_cannot_be_in_the_future

  def date_cannot_be_in_the_future
    if date.present? && date > Date.today
      errors.add(:date, "can't be in the future")
    end
  end

  def date_must_be_valid
    if date_before_type_cast.present?
      begin
        Date.parse(date_before_type_cast.to_s)
      rescue ArgumentError, TypeError
        errors.add(:date, "not a valid date")
      end
    end
  end
end
