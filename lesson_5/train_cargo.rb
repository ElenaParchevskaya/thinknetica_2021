require_relative 'train'
require_relative 'vagon_cargo'

class TrainCargo < Train
  def attach_vagon(vagon)
    if vagon.class == VagonCargo
    super
    else
      puts "Вагон = #{vagon}, должен быть грузовой вагоны"
    end
  end
end
