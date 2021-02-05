require_relative 'manufacturer_company'
require_relative 'module_functions'

class Vagon
  include ManufacturerCompany
  include Functions

  attr_reader :length, :height

  def initialize(length, height)
    @length = length
    @height = height
  end

  protected

  def validate!
    raise 'Длинна не должна превышать 14 метров' if length > 14
    raise 'Высота не должна превышать 5 метров' if height > 5
  end
end
