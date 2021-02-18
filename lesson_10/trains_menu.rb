require_relative 'train'
require_relative 'train_passenger'
require_relative 'train_cargo'
require_relative 'vagon'
require_relative 'vagon_passenger'
require_relative 'vagon_cargo'
require_relative 'route_menu'
require_relative 'station_menu'
require_relative 'functions'
require_relative 'validation_error'
require_relative 'validation'

module TrainMenu
  include InstanceCounter
  include Functions
  include RouteMenu
  include StationMenu
  include Validation

  private

  def trains_menu
    loop do
      puts '==========================================='
      puts '            работа с поездами              '
      puts '0 - назад'
      puts '1 - создание грузового поезда'
      puts '2 - создаие пассажирского поезда'
      puts '3 - список поездов'
      puts '4 - управление поездом'
      puts '==========================================='
      case gets.chomp.to_i
      when 0 then return
      when 1 then train_create_cargo
      when 2 then train_create_passenger
      when 3 then train_list
      when 4 then train_manage_menu
      end
    end
  end

  def train_manage_menu
    return unless train_list

    print 'Введите номер поезда:'
    train = gets.chomp.to_i
    if @trains[train].nil?
      puts '--- Такого поезда нет! ---'
      false
    else
      loop do
        puts '==========================================='
        puts "\nработа с поездом #{@trains[train].number}"
        puts ' 0 - Назад'
        puts ' 1 - назначить маршрут поезду'
        puts ' 2 - добавить вагон к поезду'
        puts ' 3 - отцепить вагон у поезда'
        puts ' 4 - переместить поезд на станцию вперед'
        puts ' 5 - переместить поезд на станцию назад'
        puts ' 6 - просмотр текущей станции'
        case gets.chomp.to_i
        when 0 then return
        when 1 then train_set_route train
        when 2 then @trains[train].carriage_add
        when 3 then @trains[train].carriage_remove
        when 4 then train_move_forward train
        when 5 then @trains[train].move_back
        when 6 then puts @trains[train].print_station
        end
      end
    end
  end

  def train_list
    puts "\nСписок поездов"
    if !trains.empty?
      trains.each.with_index { |train, i| puts "Поезд #{i}: #{train.number}, тип #{train.type}, количество вагонов #{train.carriages.size}" }
      puts '-------------------------------------------'
      true
    else
      puts '##### поездов нет! #####'
      false
    end
  end

  def train_create_cargo(train_number = nil, num_carriages = nil)
    if train_number.nil?
      print 'Создание грузового поезда. Введите номер (по формату: ххх-xx)   '
      train_number = gets.chomp
    end
    if num_carriages.nil?
      print 'Введите количество вагонов:'
      num_carriages = gets.chomp.to_i
    end
    @trains << TrainCargo.new(train_number, num_carriages)
  rescue ValidationError => e
    puts e.message
    puts 'Возникла ошибка. Поезд не создан.'
  end

  def train_create_passenger(train_number = nil, num_carriages = nil)
    if train_number.nil?
      print 'Создание пассажирского поезда. Введите номер (по формату: ххх-xx)   '
      train_number = gets.chomp
    end
    if num_carriages.nil?
      print 'Введите количество вагонов:'
      num_carriages = gets.chomp.to_i
    end
    @trains << TrainPassenger.new(train_number, num_carriages)
  rescue ValidationError => e
    puts e.message
    puts 'Возникла ошибка. Поезд не создан.'
  end

  def train_set_route(train, route = nil)
    if route.nil?
      return unless route_list

      print 'Введите номер маршрута на который передвигаем поезд:'
      route = gets.chomp.to_i
    end
    @trains[train].new_route(@routes[route])
  end

  def train_move_forward(train)
    @trains[train].move_forward
  end
end
