require_relative 'train'
class Station

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
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
