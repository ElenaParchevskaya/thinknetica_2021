class Train

  attr_accessor :speed, :vagons
  attr_reader :type, :number

  def initialize(number, type, vagons)
    @number = number
    @type = type
    @vagons = vagons
    @speed = 0
    @route = []
    @railway_station
  end

  def speed_up(speed = 10)
    self.speed += speed
  end

  def stop
    self.speed = 0
  end

  def vagons_count
    self.vagons
  end

  def vagon_add
    self.vagons += 1 if self.speed == 0
  end

  def vagon_delete
    self.vagons -= 1 if self.speed == 0 && !self.vagons.zero?
  end

  def next_station
    @route.stations[@route.stations.index(@railway_station) + 1]
  end

  def prev_station
    unless @route.stations.index(@railway_station) - 1 == - 1
      @route.stations[@route.stations.index(@railway_station) - 1]
    end
  end

  def add_route (route)
    @route = route
    @railway_station = @route.stations[0]
    @railway_station.train_in(self)
  end

  def route_forward
    return unless next_station
    @railway_station.train_out(self)
    @railway_station = next_station
    @railway_station.train_in(self)
  end

  def route_backward
    return unless prev_station
    @railway_station.train_out(self)
    @railway_station = prev_station
    @railway_station.train_in(self)
  end

  def what_station
    return if @route.stations.empty?
    puts "Train at the station: #{@curr_station.name}"
    puts "Previous station: #{prev_station ? prev_station.name : 'no station'}"
    puts "The next station: #{next_station ? next_station.name : 'no station' }"
  end
end
