require_relative 'vagon'
require_relative 'vagon_passenger'
require_relative 'vagon_cargo'
require_relative 'train'
require_relative 'train_passenger'
require_relative 'train_cargo'
require_relative 'station'
require_relative 'route'
# require_relative 'station_actions'

class Interface
  attr_reader  :stations,  :routes,  :trains

  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  def start
    loop do
      puts '==========================================='
      puts '0 - Выход'
      puts '1 - Действия со станциями'
      puts '2 - Действия с поездами'
      puts '3 - Действия с маршрутами'
      puts '==========================================='
      option = gets.chomp.to_i
      case option
      when 1
        station_actions(stations)
      when 2
        trains_actions(trains, routes)
      when 3
        route_actions(routes, stations)
      else
        break if option.zero?
      end
    end
  end

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

  def trains_actions(trains, routes)
    loop do
      puts '==========================================='
      puts '0 - Назад'
      puts '1 - Создать поезд'
      puts '2 - Посмотреть поезда'
      puts '3 - Добавить вагон'
      puts '4 - Отцепить вагон'
      puts '5 - Назначить маршрут поезду'
      puts '6 - Переместить поезд на следующую станцию'
      puts '7 - Переместить поезд на предыдущую станцию'
      puts '==========================================='
      option = gets.chomp.to_i
      case option
      when 1 then add_train(trains)
        when 2 then list_trains(trains)
        when 3 then vagons_actions(trains, 'add')
        when 4 then vagons_actions(trains, 'delet')
        when 5 then assign_route(trains, routes)
        when 6 then move_trains(trains, 'forward')
        when 7 then move_trains(trains, 'back')
        else
          puts 'Введите цифру от 0 до 6'
      end
      break if option.zero?
    end
  end

  def add_train(trains)
    loop do
      puts 'Введите номер поезда:'
      id = gets.chomp
      puts 'Выберите тип поезда:', '1. Пассажирский', '2. Грузовой'
      type = gets.chomp
      train = TrainPassenger.new(id) if type.to_i == 1
      train = TrainCargo.new(id) if type.to_i == 2
      trains << train
      break
    end
  end

  def list_trains(trains)
    trains.each_with_index do |train, index|
      type = 'пассажирский' if train.class == TrainPassenger
      type = 'грузовой' if train.class == TrainCargo
      puts "#{index + 1}. Поезд №#{train.id}, тип #{type}, вагонов #{train.vagons.size}"
    end
  end

  def move_trains(trains, direction)
    puts 'Выберите поезд из списка поездов:'
    list_trains(trains)
    puts 'Введите номер поезда для выполнения операции'
    index = gets.chomp.to_i
    index -= 1
    if trains[index].nil?
      puts "Выберите поезд из диапозона 1 - #{trains.size}"
    elsif trains[index].route.nil?
      puts 'Не присвоен маршрут'
    else
      trains[index].travel(direction)
    end
  end

  def assign_route(trains, routes)
    puts 'Выберите маршрут:'
    list_routes(routes)
    route = gets.chomp.to_i
    puts 'Выберите поезд:'
    list_trains(trains)
    train = gets.chomp.to_i
    trains[train - 1].add_route(routes[route - 1])
  end

  def add_vagon(train)
    vagon = VagonPassenger.new 100, 'coupe' if train.class == TrainPassenger
    vagon = VagonCargo.new 100, 'coupe' if train.class == TrainCargo
    train.attach_vagon(vagon)
  end

  def delet_vagon(train)
    train.delet_vagon(train.vagons.last)
  end

  def vagons_actions(trains, operation)
    puts 'Выберите поезд из списка поездов:'
    list_trains(trains)
    puts 'Введите номер поезда для добавления/удаления вагона'
    index = gets.chomp.to_i
    true_index = index - 1
    if trains[true_index].nil?
      puts "Выберите поезд из диапозона 0 - #{trains.size}"
    else
      add_vagon(trains[true_index]) if operation == 'add'
      delet_vagon(trains[true_index]) if operation == 'delet'
      puts "Поезд имеет #{trains[true_index].vagons.size} вагонов"
    end
  end

  def route_actions(routes, stations)
    loop do
      puts '==========================================='
      puts '0 - Назад'
      puts '1 - Создать маршрут'
      puts '2 - Добавить станцию в маршрут'
      puts '3 - Удалить станцию в маршруте'
      puts '4 - Просмотреть все маршруты'
      puts '==========================================='
      option = gets.chomp.to_i
      case option
      when 1 then add_route(stations, routes)
        when (2..3) then choose_route(stations, routes, option)
        when 4 then list_routes(routes)
      end
      break if option.zero?
    end
  end

  def add_route(stations, routes)
    puts 'Выберите станицию из списка:'
    list_stations(stations)
    puts 'Введите номер начальной станции'
    from_station = gets.chomp.to_i - 1

    puts 'Введите номер конечной станции'
    to_station = gets.chomp.to_i - 1
    if stations[from_station].nil? || stations[to_station].nil?
      puts "Выберите станцию из диапозона 1 - #{stations.size}"
    else
      routes << Route.new(stations[from_station], stations[to_station])
      puts 'Маршрут создан'
    end
  end

  def list_routes(routes)
    routes.each_with_index do |route, index|
      puts "#{index + 1}. маршрут #{route.from_station.name} - #{route.to_station.name}"
      puts 'Всего станций в маршруте:'
      route.stations.each { |station| puts station.name }
    end
  end

  def choose_route(stations, routes, option)
    puts "Выбрите маршрут из диапозона 1 - #{routes.size}:"
    list_routes(routes)
    choice = gets.chomp.to_i

    route = routes[choice - 1]
    puts 'Выберите станицию из списка:'
    list_stations(stations)
    choice = gets.chomp.to_i
    choice -= 1

    if stations[choice].nil?
      puts "Выберите стнацию из диапозона 1 - #{stations.size}"
    else
      route.add_station(stations[choice]) if option == 2
      route.delet_station if option == 3
    end
  end
end

Interface.new.start
