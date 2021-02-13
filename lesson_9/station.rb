require_relative 'validation_error'
require_relative 'modules'

class Station
  include Functions
  include InstanceCounter

  NAMEFORMAT = /^[a-яa-z0-9\-, ]+$/i.freeze
  ERRORNAMELENGTH = 'длина названия должна быть не меньшу 2 букв'.freeze
  ERRORNAMEFORMAT = 'название должно состоять из кириллицы (а-я)'.freeze

  attr_reader :trains, :name

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    validate!
    @trains = []
    register_instance
    @@stations << self
  end

  def train_add(train)
    @trains << train
  end

  def trains_print
    trains_num = []
    @trains.each { |train| trains_num << train }
    trains_num
  end

  def trains_print_type(type)
    trains_by_type = []
    @trains.each { |train| trains_by_type << train.number if train.type == type }
    trains_by_type
  end

  def train_departure(train)
    @trains.delete(train)
  end

  def each_train
    @trains.each { |train| yield(train) }
  end

  protected

  def validate!
    raise ValidationError, ERRORNAMEFORMAT if @name !~ NAMEFORMAT
    raise ValidationError, ERRORNAMELENGTH if @name.length < 2
  end
end
