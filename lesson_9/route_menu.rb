require_relative 'station'
require_relative 'route'
require_relative 'station_menu'
require_relative 'trains_menu'
require_relative 'validation_error'
require_relative 'modules'

module RouteMenu
  private

  def route_menu
    loop do
      puts '==========================================='
      puts '           работа с маршрутами             '
      puts ' 0 - назад'
      puts ' 1 - создание маршрута'
      puts ' 2 - просмотр маршрута'
      puts ' 3 - просмотр списка маршрутов'
      puts ' 4 - управление маршрутом'
      case gets.chomp.to_i
      when 0 then return
      when 1 then route_create
      when 2 then route_show
      when 3 then route_list
      when 4 then route_manage_menu
      end
    end
  end

  def route_manage_menu
    return unless route_list

    print 'Введите номер маршрута'
    route = gets.chomp.to_i
    if @routes[route].nil?
      puts '--- Такого маршрута нет ---'
      false
    else
      loop do
        puts '==========================================='
        puts "\n   работа с маршрутом #{@routes[route]}  "
        puts ' 0 - назад'
        puts ' 1 - добавление страниции к маршруту'
        puts ' 2 - удаление страниции из маршрута'
        puts ' 3 - просмотр маршрута'
        case gets.chomp.to_i
        when 0 then return
        when 1 then route_station_add route
        when 2 then route_station_delete route
        when 3 then route_show route
        end
      end
    end
  end

  def route_list
    puts "\n----------  Список маршрутов на данной железной дороге ----------"
    if !routes.empty?
      routes.each.with_index { |route, i| puts "Маршрут #{i}: #{route}" }
      puts '-----------------------------------------------------------------'
      true
    else
      puts '----- маршрутов пока нет! ------'
      false
    end
  end

  def route_create(from = nil, to = nil)
    if from.nil? || to.nil?
      puts "\n\n======== Список номеров станций ========"
      station_list
      print 'Введите через пробел номер начальной и конечной станции:'
      from, to = gets.chomp.split(' ').map(&:to_i)
    end
    return if !station_exists?(from) || !station_exists?(to)

    routes << Route.new(@stations[from], @stations[to])
  end

  def route_show(route = nil)
    if route.nil?
      return unless route_list

      print 'Введите номер маршрута, который необходимо посмотреть:'
      route = gets.chomp.to_i
    end
    return @routes[route].route_print if @routes[route]

    puts '--- Такого маршрута нет ---'
    false
  end

  def route_station_add(route, station_num = nil)
    if station_num.nil?
      return unless station_list

      print 'Введите номер станции, которую надо добавть в маршрут:'
      station_num = gets.chomp.to_i
    end
    station = @stations[station_num]
    return @routes[route].station_add station if station

    puts '--- Такой станции нет ---'
    false
  end

  def route_station_delete(route, station_num = nil)
    if station_num.nil?
      return unless station_list

      print 'Введите номер станции, которую надо удалить из маршрута:'
      station_num = gets.chomp.to_i
    end
    station = @stations[station_num]
    return @routes[route].station_remove station if station

    puts '--- Такой станции нет ---'
    false
  end
end
