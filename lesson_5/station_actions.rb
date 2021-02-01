require_relative 'station'

def add_station(stations)
  loop do
    puts 'Введите название станции:'
    name = gets.chomp.to_s
    station = Station.new name
    stations << station
    puts "Создана станция #{station.name}"
    break
  end
end

def list_stations(stations)
  stations.each_with_index  do |station, index|
    puts "#{index + 1}. станция #{station.name}, поезда на станции:"
    station.trains.each { |train| puts "Поезд номер #{train.id}" }
  end
end

def  station_actions(stations)
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
