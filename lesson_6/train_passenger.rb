require_relative 'train'
require_relative 'vagon_passenger'

class TrainPassenger < Train
  def attach_vagon(vagon)
    if vagon.class == VagonPassenger
      super
    else
      puts "Вагон = #{vagon}, должен быть пассажирский вагон"
    end
  end

end
