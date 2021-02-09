require_relative 'train_passenger'
require_relative 'train_cargo'
require_relative 'vagons_actions'
require_relative 'route_actions'
require_relative 'train'
require_relative 'module_functions'
require_relative 'validation_error'

module TrainAction
  private

  include VagonAction

  PASSENGER = ' пассажирский'
  CARGO = ' грузовой'

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
      puts 'Введите номер поезда, формат ххх-хх, где х - число/буква(кириллица) '
      id = gets.chomp
      puts "Выбебрите тип  1 #{PASSENGER}, 2 #{CARGO}"
      type = gets.chomp
      begin
        train = TrainPassenger.new(id) if type.to_i == 1
        train = TrainCargo.new(id) if type.to_i == 2
        trains << train
        puts "Создан поезд #{id}"
      rescue ValidationError => e
        puts 'Поезд не создан'
        puts e.message
      end
      break
    end
  end

  def list_trains(trains)
    puts 'Поездов нет' if trains.empty? # НЕТ ПОЕЗДОВ
    trains.each_with_index do |train, index|
      type = PASSENGER if train.class == TrainPassenger
      type = CARGO if train.class == TrainCargo
      puts "#{index + 1}. Поезд №#{train.id}, тип #{type}, вагонов #{train.vagons.size}"
    end
  end

  def move_trains(trains, direction)
    puts 'Поездов нет' if trains.empty? # НЕТ ПОЕЗДОВ
    puts 'Выберите поезд из списка поездов:'
    list_trains(trains)
    puts 'Введите номер поезда для выполнения операции'
    index = gets.chomp.to_i
    index -= 1
    if trains[index].nil?
      puts "Выберите поезд из диапозона 1 - #{trains.size}"
    elsif trains[index].route.nil?
      puts 'Маршрут не присвоен'
    else
      trains[index].travel(direction)
    end
  end

  def assign_route(trains, routes)
    puts 'Поездов нет' if trains.empty? # НЕТ ПОЕЗДОВ
    puts 'Выберите маршрут'
    list_routes(routes)
    route = gets.chomp.to_i
    puts 'Выберите поезд:'
    list_trains(trains)
    train = gets.chomp.to_i
    trains[train - 1].add_route(routes[route - 1])
  end
end
