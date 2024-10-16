class LunarCell < ApplicationRecord
  before_validation :generate_serial_number, on: :create
  has_many :moon_batteries, foreign_key: :connected_lunar_cell_id
  validates :serial_number, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
  def generate_serial_number
    self.serial_number = SecureRandom.hex(3).upcase.slice(0, 6)
  end
end
