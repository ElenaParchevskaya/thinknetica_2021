require_relative 'train'
require_relative 'instance_counter'

class Station
  @@stations = []

  def self.all
    @@stations
  end

  include InstanceCounter
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instatnce
  end

  def train_in(train)
    puts "Поезд #{train.id} приехал на станицию #{@name}"
    @trains << train
  end

  def train_out(train)
    puts "Поезд #{train.id} уехал со станции #{@name}"
    @trains.delete(train)
  end
end
