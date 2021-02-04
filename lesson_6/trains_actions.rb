require_relative 'train_passenger'
require_relative 'train_cargo'
require_relative 'vagons_actions'
require_relative 'route_actions'

module TrainAction
  private
  
  include VagonAction

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
end
