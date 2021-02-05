require_relative 'route'
require_relative 'station'
require_relative 'station_actions'

module RouteAction
  private

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
    puts 'Станций нет' if stations.empty?
    puts 'Выберите станицию из списка:'
    list_stations(stations)
    puts 'Введите номер начальной станции'
    from_station = gets.chomp.to_i - 1
    puts 'Введите номер конечной станции'
    to_station = gets.chomp.to_i - 1
    if stations[from_station].nil? || stations[to_station].nil?
      puts "Выберите станцию из диапозона:  #{stations.size}"
    else
      routes << Route.new(stations[from_station], stations[to_station])
      puts 'Маршрут создан'
    end
  end

  def list_routes(routes)
    puts "Машрутов нет" if stations.empty? # НЕТ МАРШРУТОВ
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
