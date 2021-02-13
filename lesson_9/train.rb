require_relative 'validation_error'
require_relative 'modules'

class Train
  include Functions
  include InstanceCounter
  include Producer

  IDFORMAT = /^([а-я]|\d){3}-*([а-я]|\d){2}$/i.freeze
  ERRORIDLENGTH = 'Длина номера не должна превышать 5 цифр/букв(крилллица)'.freeze
  ERRORIDFORMAT = 'Не верный формат, заполните по формату: ххх-xx, где - х любая цифра/буква(крилллица)'.freeze
  ERRORTRAINO = 'Поездов нет'.freeze

  attr_accessor :speed
  attr_reader :carriages, :number, :type, :num_carriages

  @@trains = {}

  def self.find(num)
    @@trains[num]
  end

  def initialize(number, num_carriages)
    @number = number
    @num_carriages = num_carriages
    validate!
    register_instance
    @@trains[number] = self
  end

  def brake
    @speed = 0
  end

  def carriage_remove
    @carriages.pop
  end

  def carriage_change(num)
    @carriage += num if @speed == 0 && num.abs == 1
    @carriage = 1 if @carriage < 1
  end

  def print_station
    @route.route[@current_station].name
  end

  def new_route(route)
    @route = route
    @current_station = 0
    @route.route[@current_station].train_add(self)
  end

  def move_forward
    if @current_station < (@route.route.length - 1)
      @route.route[@current_station].train_departure(self)
      @current_station += 1
      @route.route[@current_station].train_add(self)
    end
  end

  def move_back
    if @current_station > 0
      @route.route[@current_station].train_departure(self)
      @current_station -= 1
      @route.route[@current_station].train_add(self)
    end
  end

  def where_in_route
    [@current_station > 0 ? @route.route[@current_station - 1] : nil,
     @route.route[@current_station],
     @current_station < (@route.route.length - 1) ? @route.route[@current_station + 1] : nil]
  end

  def each_carriage
    @carriages.each.with_index(1) { |carriage, i| yield(carriage, i) }
  end

  protected

  def validate!
    raise ValidationError, ERRORIDLENGTH if @number.gsub('-', '').length > 5
    raise ValidationError, ERRORIDFORMAT if @number !~ IDFORMAT
    raise ValidationError, 'Некорректное количество вагонов' if num_carriages < 1
  end
end
