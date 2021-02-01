require_relative 'vagon_passenger'
require_relative 'vagon_cargo'
require_relative 'train_passenger'
require_relative 'train_cargo'

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
