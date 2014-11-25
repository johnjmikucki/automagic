class Donut < ActiveRecord::Base
  validates_presence_of :name
  validates :fat, presence: true, numericality: {greater_than: 0}, if: :released
  validates :carb, presence: true, numericality: {greater_than: 0}, if: :released
  validates :protein, presence: true, numericality: {greater_than: 0}, if: :released
end
