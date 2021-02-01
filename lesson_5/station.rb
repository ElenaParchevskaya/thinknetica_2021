class Station

  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def train_in(train)
    @trains << train
  end

  def train_out(train)
    @trains.delete(train)
  end

  def output
    return if @trains.empty?
    puts "Trains at the station  #{@name}:"
    @trains.each do |train|
      puts "Train number: #{train.number}, type: #{train.type}"
    end
  end

  def output_type(type)
    number_type = @trains.count{|train| train.type == type}
    puts "Train type #{type} at the station: #{number_type}"
  end
end
