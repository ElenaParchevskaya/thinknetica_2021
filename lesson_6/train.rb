require_relative 'manufacturer_company'
require_relative 'instance_counter'

class Train
  @@trains = {}

  def self.find(search)
    @@trains[search.to_sym]
  end

  include ManufacturerCompany
  include InstanceCounter
  attr_reader :speed, :vagons, :route, :id
  attr_reader :previous_station, :current_station, :next_station

  def initialize(id)
    @id = id
    @vagons = []
    @speed = 0
    @@trains[id.to_sym] = self
    register_instance
  end

  def stop
    @speed = 0
  end

  def attach_vagon(vagon)
    conditions_check
    @vagons << vagon if speed.zero?
  end

  def delet_vagon(vagon)
    conditions_check
    @vagons.delete(vagon) if speed.zero?
  end

  def add_route(route)
    @route = route
    @route.stations.first.train_in self
    stations current_position
  end

  def travel(direction)
    if direction != 'forward' && direction != 'back'
      puts "Пожалуйста, введите 'forward' или 'back'"
    else
      case direction
        when 'forward'then index = current_position + 1
        when 'back' then index = current_position - 1
      end
      move_train index
    end
  end

  private

  # проверка скорости
  def conditions_check
    puts 'Первая остановка поезда' if speed != 0
  end

  # для метода Travel
  def current_position
    @route.stations.find_index { |station| station.trains.include?(self) }
  end

  def move_train(new_position)
    if nil_or_negative? new_position
      puts 'Это 1 или последня станция'
    else
      stations new_position
      @route.stations[current_position].train_out(self)
      @route.stations[new_position].train_in(self)
    end
  end
  #установка станций после перемещения поезда
  def stations(set)
    @next_station = nil
    @previous_station = nil
    previous = set - 1
    next_ensuing = set + 1
    @previous_station = @route.stations[previous].name unless nil_or_negative?previous
    @current_station = @route.stations[set].name
    @next_station = @route.stations[next_ensuing].name unless nil_or_negative? next_ensuing
  end

  #  есть в массиве такой индекс или отрицательное число?
  def nil_or_negative?(number)
    @route.stations[number].nil? || number.negative?
  end
end
