require_relative 'train'
require_relative 'instance_counter'
require_relative 'module_functions'

class Station
  include InstanceCounter
  include Functions

  RUSNAME = /^[А-я]/
  ERRORNAMELENGTH = 'Длина названия должна быть не меньшу 2 букв'.freeze
  ERRORNAMEFORMAT = 'Название должно состоять из кириллицы (а-я)'.freeze

  attr_reader :trains
  attr_accessor :name

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations << self
    register_instance
  end

  def train_in(train)
    puts "Поезд #{train.id} приехал на станицию #{@name}"
    @trains << train
  end

  def train_out(train)
    puts "Поезд #{train.id} уехал со станции #{@name}"
    @trains.delete(train)
  end

  protected

  def validate!
    raise ERRORNAMEFORMAT if @name !~ RUSNAME
    raise ERRORNAMELENGTH if @name.length < 2
  end
end
