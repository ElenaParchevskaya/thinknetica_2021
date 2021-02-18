require_relative 'validation_error'
require_relative 'validation'

module Functions
  include Validation
  
  def self.included(base)
    base.send :include, InstanceMethods
  end
end
