require_relative 'vagon'

class VagonCargo < Vagon
  attr_reader :capacity, :roof

  def initialize(capacity)
    super(9, 7)
    @capacity = capacity
  end
end
