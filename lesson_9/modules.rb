require_relative 'validation_error'

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      @instances ||= 0
    end

    private

    def instances_count
      @instance ||= 0
      @instance += 1
    end
  end

  module InstanceMethods
    private

    def register_instance
      self.class.send :instances_count
    end
  end
end

module Functions
  def self.included(base)
    base.send :include, InstanceMethods
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue ValidationError
    end
  end
end

module Producer
  attr_accessor :producer
end
