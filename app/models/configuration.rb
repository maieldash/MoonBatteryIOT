class Configuration < ApplicationRecord
  after_initialize :set_defaults
  belongs_to :moon_battery
  validates :moon_battery_id, presence: true
  validates :key, presence: true, inclusion: { in: ['temperature','mode']}
  validates :value, presence: true

  private def set_defaults

  end
end
