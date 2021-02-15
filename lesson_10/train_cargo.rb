require_relative 'train'

class TrainCargo < Train
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
