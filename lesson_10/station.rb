require_relative 'validation_error'
require_relative 'functions'
require_relative 'instance_counter'
require_relative 'accessors'
require_relative 'validation'

class Station
  include Functions
  include InstanceCounter
  extend Accessors
  include Validation

  NAMEFORMAT = /^[a-яa-z0-9\-, ]+$/i.freeze
  # ERRORNAMELENGTH = 'длина названия должна быть не меньше 2 букв'.freeze
  # ERRORNAMEFORMAT = 'Некорректное название'.freeze

  attr_reader :trains, :name

  validate :name, :presence
  validate :name, :format, NAMEFORMAT

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
  #
  # protected
  #
  # def validate_station
  #   raise ValidationError, ERRORNAMEFORMAT unless validate! name, :format, NAMEFORMAT
  #   raise ValidationError, ERRORNAMELENGTH if @name.length < 2
  # end
end
