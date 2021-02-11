require_relative 'train'
require_relative 'train_passenger'
require_relative 'train_cargo'

require_relative 'station'
require_relative 'route'

require_relative 'vagon'
require_relative 'vagon_passenger'
require_relative 'vagon_cargo'

require_relative 'station_menu'
require_relative 'trains_menu'
require_relative 'route_menu'
require_relative 'test_data'

class Interface
  include RouteMenu
  include StationMenu
  include TrainMenu
  include TestData

  attr_reader  :stations,  :routes,  :trains

  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  def start_menu
    loop do
      puts '==========================================='
      puts '0 - Выход'
      puts '1 - Действия со станциями'
      puts '2 - Действия с поездами'
      puts '3 - Действия с маршрутами'
      puts '4 - Тестовые примеры'
      puts '==========================================='
      case gets.chomp.to_i
      when 0  then return
      when 1  then station_menu
      when 2  then trains_menu
      when 3  then route_menu
      when 4 then test_data
      end
    end
  end
end

Interface.new.start_menu
