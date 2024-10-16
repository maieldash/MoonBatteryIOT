class MoonBattery < ApplicationRecord
  before_validation :generate_serial_number, on: :create
  belongs_to :connected_lunar_cell, class_name: 'LunarCell', optional: true
  validates :mac_address, presence: true, uniqueness: true
  validates :serial_number, presence: true, uniqueness: true
  validates :charge_level, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :temperature, presence: true
  validates :mode, presence: true, inclusion: %w[eco normal]
  validates :power_limit, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5000 }
  def ping!
    update(last_ping: Time.now)
  end
  private
  def generate_serial_number
    self.serial_number = SecureRandom.hex(3).upcase.slice(0, 6)
  end
end
