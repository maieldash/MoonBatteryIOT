class LunarCell < ApplicationRecord
  has_many :moon_batteries, foreign_key: :connected_lunar_cell_id
  validates :name, presence: true, uniqueness: true
end
