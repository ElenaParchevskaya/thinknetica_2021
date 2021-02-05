require_relative 'manufacturer_company'
require_relative 'instance_counter'
require_relative 'module_functions'

class Train
  include ManufacturerCompany
  include InstanceCounter
  include Functions

  IDFORMAT = /^([а-я]|\d){3}-*([а-я]|\d){2}$/i
  ERRORIDLENGTH = 'Длина номера не должна превышать 5 цифр/букв(крилллица)'.freeze
  ERRORIDFORMAT = 'Не верный формат, заполните по формату: ххх-xx, где - х любая цифра/буква(крилллица)'.freeze
  ERRORTRAINO = 'Поездов нет'


  attr_reader :speed, :vagons, :route, :id
  attr_reader :previous_station, :current_station, :next_station

  @@trains = {}

  def self.find(search)
    @@trains[search.to_sym]
  end

  def initialize(id)
    @id = id
    @vagons = []
    @speed = 0
    validate!
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

  def travel_forward
    index = current_position + 1
    move_train index
  end

  def travel_back
    index = current_position - 1
    move_train index
  end

  protected

  def validate!
    raise ERRORIDLENGTH if @id.gsub('-','').length > 5
    raise ERRORIDFORMAT if @id !~ IDFORMAT
    raise ERRORIDFORMAT if train.empty?
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
