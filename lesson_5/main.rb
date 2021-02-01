require_relative 'station_actions'
require_relative 'vagon'
require_relative 'vagon_passenger'
require_relative 'vagon_cargo'
require_relative 'train'
require_relative 'train_passenger'
require_relative 'train_cargo'
require_relative 'train_actions'
require_relative 'route_actions'

stations = []
trains = []
routes = []

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
