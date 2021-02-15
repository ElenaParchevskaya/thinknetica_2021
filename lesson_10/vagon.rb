require_relative 'validation_error'
require_relative 'producer'

class Vagon
  include Producer

  attr_accessor :train_name
  attr_reader :type, :reserved

  def initialize(train_name, total)
    @train_name = train_name
    @total = total
    @reserved = 0
  end

  def free_volume
    @total - @reserved
  end

  def reserve(volume)
    @reserved += volume if free_places >= volume
  end
end
