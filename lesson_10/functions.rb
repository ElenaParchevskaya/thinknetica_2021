require_relative 'validation_error'

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
