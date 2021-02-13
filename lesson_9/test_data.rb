module TestData
  ONEINDENT = '-------------------------------------------------------------'.freeze
  TWOINDENT = '============================================================='.freeze

  def test_data
    station_create 'Минск'
    station_create 'Гомель'
    station_create 'Калинковичи'
    station_create 'Мозырь'
    station_create 'Брест'
    station_create 'Гродно'
    station_create 'Витебск'
    station_create 'Пинск'
    station_create 'Вилейка'
    station_create 'Станция счастья'
    station_create 'Бобровичи'
    station_create 'Борисов'
    route_create 0, 1
    route_station_add 0, 2
    route_create 3, 11
    route_station_add 1, 9
    route_station_add 1, 10
    route_station_add 1, 11
    route_create 3, 4
    route_station_add 2, 5
    route_station_add 2, 6
    route_station_add 2, 7
    route_station_add 2, 8
    train_create_cargo('111-11', 7)
    train_create_cargo('111-12', 11)
    train_create_cargo('111-13', 10)
    train_create_cargo('111-14', 9)
    train_create_cargo('111-15', 8)
    train_create_cargo('111-16', 17)
    train_create_cargo('111-17', 6)
    train_create_cargo('111-18', 25)
    train_create_passenger('211-11', 2)
    train_create_passenger('211-12', 4)
    train_create_passenger('211-13', 20)
    train_create_passenger('211-14', 9)
    train_create_passenger('211-15', 8)
    train_create_passenger('211-16', 7)
    train_create_passenger('211-17', 16)
    train_create_passenger('211-18', 5)
    train_set_route(0, 0)
    train_set_route(1, 1)
    train_move_forward(1)
    train_set_route(2, 2)
    train_set_route(3, 0)
    train_move_forward(3)
    train_set_route(4, 1)
    train_set_route(5, 2)
    train_move_forward(5)
    train_set_route(6, 0)
    train_set_route(7, 1)
    train_move_forward(7)
    train_set_route(8, 2)
    train_set_route(9, 0)
    train_move_forward(9)
    train_set_route(10, 1)
    train_set_route(11, 2)
    train_move_forward(11)
    train_set_route(12, 0)
    train_set_route(13, 1)
    train_move_forward(13)
    train_set_route(14, 2)
    train_set_route(15, 0)
    carriages_block = proc { |carriage, i| puts "Вагон номер #{i}, тип #{carriage.type}, свободно #{carriage.free_volume}, занято #{carriage.reserved}" }
    puts '============== использование блока для станций =============='
    Station.all.each do |station|
      puts "====== использование блока для станции #{station.name} ========"
      station.each_train do |train|
        puts "Поезд #{train.number}, тип #{train.type}, количество вагонов #{train.carriages.size}"
        puts '--------- использование блока для данного поезда ---------'
        train.each_carriage do |carriage, i|
          carriages_block.call(carriage, i)
        end
        puts ONEINDENT
      end
      puts TWOINDENT
    end
  end
end
