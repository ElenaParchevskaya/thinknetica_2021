require_relative 'station'
require_relative 'instance_counter'

class Route
  include InstanceCounter
  attr_reader :stations, :from_station, :to_station

  def initialize(from_station, to_station)
    @from_station = from_station
    @to_station = to_station
    @stations = [from_station, to_station]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def from_station?(station)
    station != stations.first
  end

  def to_station?(station)
    station != stations.last
  end

  def delet_station(station)
    @stations.delete(station) if from_station?(station) && to_station?(station)
  end
end
