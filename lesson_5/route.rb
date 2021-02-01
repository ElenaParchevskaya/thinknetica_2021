class Route

  attr_accessor :stations

  def initialize(from_station, to_station)
    @stations = [from_station, to_station]
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def first_station?(station)
    station != stations.first
  end

  def last_station?(station)
    station != stations.last
  end

  def dellet_station(station)
    stations.delete(station) if first_station?(station) && last_station?(station)
  end

  def list
    self.stations.each.with_index(1) do |station, index|
      puts "#{index}.  #{station.name}"
    end
  end

end
