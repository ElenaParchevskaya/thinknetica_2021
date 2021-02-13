# frozen_string_literal: true

class VagonCargo < Vagon
  attr_reader :reserved

  def initialize(train_name, volume)
    @type = :cargo
    super
  end
end
