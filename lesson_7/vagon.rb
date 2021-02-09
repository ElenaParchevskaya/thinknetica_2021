require_relative 'manufacturer_company'

class Vagon

  attr_reader :length, :height

  def initialize(length, height)
    @length = length
    @height = height
  end
end
