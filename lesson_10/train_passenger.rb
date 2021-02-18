require_relative 'train'
require_relative 'validation_error'

class TrainPassenger < Train

  IDFORMAT = /^([а-я]|\d){3}-*([а-я]|\d){2}$/i.freeze

  validate :number, :presence
  validate :number, :format, IDFORMAT

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
