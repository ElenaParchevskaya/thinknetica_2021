require_relative 'train'
require_relative 'validation_error'

class TrainCargo < Train

  IDFORMAT = /^([а-я]|\d){3}-*([а-я]|\d){2}$/i.freeze

  validate :number, :presence
  validate :number, :format, IDFORMAT

  DEFAULT_VOLUME = 150

  def initialize(name, number_carriages)
    @type = :cargo
    @carriages = []
    number_carriages.times { @carriages << VagonCargo.new(name, DEFAULT_VOLUME) }
    super
  end

  def carriage_add
    @carriages << VagonCargo.new(@name, DEFAULT_VOLUME)
  end
end
