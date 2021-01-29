class Train

  attr_reader :type, :number

  def initialize(number, type, vagons)
    @number = number
    @type = type
    @vagons = vagons
    @speed = 0
  end

  def speed_up(speed = 5)
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
end
