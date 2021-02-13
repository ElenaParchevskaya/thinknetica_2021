class VagonPassenger < Vagon
  attr_reader :reserved

  def initialize(train_name, passengers)
    @type = :passenger
    super
  end

  def reserve
    super(1)
  end
end
