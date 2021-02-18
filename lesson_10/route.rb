require_relative 'validation_error'
require_relative 'instance_counter'
require_relative 'validation'

class Route
  include InstanceCounter
  include Validation

  attr_reader :route

  def initialize(station_from, station_to)
    @route = [station_from, station_to]
    register_instance
  end

  def station_add(station)
    return false if @route.include?(station)

    @route.insert(-2, station)
  end

  def station_is_middle(station)
    station != @route[0] && station != @route[-1]
  end

  def station_remove(station)
    @route.delete(station) if station_is_middle
  end

  def route_print
    route_stations = []
    @route.each { |station| route_stations << station.name }
    route_stations
  end

  def to_s
    "#{@route[0].name} - #{@route[-1].name}"
  end
end
