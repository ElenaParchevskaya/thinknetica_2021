module Functions
  def self.included(base)
    base.send :include, InstanceMethods
  end

module InstanceMethods
  def valid?
    validate!
    true
  rescue
    end
  end
end
