require_relative 'station'
require_relative 'module_functions'
require_relative 'validation_error'

module StationAction
  include InstanceCounter
  include Functions

  private

  def station_actions(stations)
    loop do
      puts '==========================================='
      puts '0 - Назад'
      puts '1 - Создать станцию'
      puts '2 - Посмотреть список станций'
      puts '==========================================='
      option = gets.chomp.to_i
      case option
      when 1 then add_station(stations)
      when 2 then list_stations(stations)
      end
      break if option.zero?
    end
  end

  def add_station(stations)
    loop do
      puts 'Введите название станции'
      name = gets.chomp.to_s
      begin
        station = Station.new name
        stations << station
        puts "Создана станция #{station.name}"
      rescue ValidationError => e
        puts 'Станция не создана'
        puts e.message
      end
      break
    end
  end

  def list_stations(stations)
    puts 'Станций нет' if stations.empty?
    stations.each_with_index  do |station, index|
      puts "#{index + 1}. станция #{station.name}, поезда на станции:"
      station.trains.each { |train| puts "Поезд номер #{train.id}" }
    end
  end
end
