require_relative 'station'
require_relative 'validation_error'
require_relative 'accessors'
require_relative 'functions'
require_relative 'instance_counter'
require_relative 'producer'
require_relative 'validation'

module StationMenu
  include InstanceCounter
  include Functions

  private

  def station_menu
    loop do
      puts '==========================================='
      puts '0 - назад'
      puts '1 - создать станцию'
      puts '2 - посмотреть список станций'
      puts '3 - посмотреть список поездов на станции'
      puts '==========================================='
      case gets.chomp.to_i
      when 0 then return
      when 1 then station_create
      when 2 then station_list
      when 3 then station_list_trains
      end
    end
  end

  def station_create(station_name = '')
    if station_name.empty?
      print "\nВведите название:"
      station_name = gets.chomp
    end
    stations.each { |station| return false if station.name == station_name }
    @stations << Station.new(station_name)
  rescue ValidationError => e
    puts e.message
    puts 'Возникла ошибка. Станция не создана.'
  end

  def station_list
    puts "\n-------- Список станций--------"
    if !stations.empty?
      stations.each.with_index { |station, i| puts "Cтанция #{i}: #{station.name}" }
      puts '-------------------------------------------'
      true
    else
      puts '##### станций нет! #####'
      false
    end
  end

  def station_print_trains(station)
    if station_exists?(station)
      @stations[station].trains_print.each { |train| puts "Поезд #{train.number}, тип #{train.type}, количество вагонов #{train.carriages.size}" }
    else
      puts 'Станции с таким номером нет.'
      false
    end
  end

  def station_exists?(station)
    station >= 0 && station < @stations.size
  end

  def station_list_trains
    puts "\nПосмотрете список станций и введите номер станции на которой нужно посмотреть поезда"
    station_list
    print 'Введите номер станции, на которой хотите посмотреть поезда:'
    station = gets.chomp.to_i
    station_print_trains(station)
  end
end
