require_relative 'vagon'

class VagonPassenger < Vagon
  attr_reader :seats, :type
  attr_accessor :wifi

  def initialize(seats, type)
    super(8, 6)
    @seats = seats
    @type = type
  end
end
