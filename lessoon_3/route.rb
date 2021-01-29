class Route

  attr_accessor :stations

  def initialize(from_station, to_station)
    @stations = [from_station, to_station]
  end

  def list
    self.stations.each.with_index(1) do |station, index|
      puts "#{index}.  #{station.name}"
    end
  end

end
