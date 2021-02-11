require_relative 'train'

class TrainPassenger < Train
  DEFAULT_PASSENGERS = 90

  def initialize(name, number_carriages)
    @type = :passenger
    @carriages = []
    number_carriages.times { @carriages << VagonPassenger.new(name, DEFAULT_PASSENGERS) }
    super
  end

  def carriage_add
    @carriages << VagonPassenger.new(@name, DEFAULT_PASSENGERS)
  end
end
