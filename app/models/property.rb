# == Schema Information
#
# Table name: properties
#
#  id              :bigint           not null, primary key
#  name            :string(128)      not null
#  property_type   :integer          not null
#  street          :string(128)      not null
#  external_number :string(12)       not null
#  internal_number :string(12)
#  neighborhood    :string(128)      not null
#  city            :string(64)       not null
#  country         :string(2)        not null
#  rooms           :integer          not null
#  bathrooms       :float            not null
#  comments        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Property < ApplicationRecord
  validates :name, presence: true, length: { maximum: 128 }
  enum property_type: {
    house: 0,
    department: 1,
    land: 2,
    comercial_ground: 3
  }
  validates :property_type, inclusion: { in: property_types.keys }, presence: true
  validates :street, presence: true, length: { maximum: 128 }
  validates :external_number, presence: true, length: { maximum: 12 }, format: { with: /\A[\p{Letter}0-9\-]+\z/ }
  # validates :internal_number, format: { with: /\A[\p{Letter}0-9\-\s]+\z/ }, presence: false
  validate :validate_internal_number
  validates :neighborhood, presence: true, length: { maximum: 128 }
  validates :city, presence: true, length: { maximum: 64 }
  validates :country, presence: true, length: { maximum: 2 }, format: { with: /\A[A-Z]+\z/ }
  validates :rooms, presence: true, numericality: { only_integer: true }
  validates :bathrooms, presence: true, numericality: { only_float: true }
  validate :validate_bathrooms
  validates :comments, length: { maximum: 128 }

  private

  def validate_internal_number
    if internal_number.present?
      errors.add(:internal_number, 'must be a valid number') unless internal_number.match?(/\A[\p{Letter}0-9\-\s]+\z/)
    end

    return unless internal_number.nil? && self.department? || self.comercial_ground?

    errors.add(:internal_number, 'Deparmets and comercial grounds must have an internal number')
  end

  def validate_bathrooms
    return if bathrooms.nil?

    return unless bathrooms.zero? && (self.department? || self.house?)

    errors.add(:bathrooms, 'The property must have at least 1 bathroom')
  end
end
