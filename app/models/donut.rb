class Donut < ActiveRecord::Base
  validates_presence_of :name
  validates :fat, presence: true, numericality: {greater_than: 0}, if: :released
  validates :carb, presence: true, numericality: {greater_than: 0}, if: :released
  validates :protein, presence: true, numericality: {greater_than: 0}, if: :released

#  attr_accessor :name
  def calories
    return nil if (fat.nil? or carb.nil? or protein.nil?)
    return 9*fat+4*carb+4*protein
  end

  # def initialize(n)
  #   super
  #   name = n
  # end
end
