require_relative 'validation_error'

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_accessor :validations

    def validate(name, validation_type, option = nil)
      @validations ||= []
      @validations << { attr: name, type: validation_type, option: option }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        validation_method = "validate_#{validation[:type]}".to_sym
        attribute = instance_variable_get("@#{validation[:attr]}")
        option = validation[:option]
        send(validation_method, attribute, option)
      end
    end

    def valid?
      validate!
        true
      rescue ValidationError
        false
    end

    def validate_presence(attribute, _option)
      raise  ValidationError, 'Не может быть пустым 'if attribute.nil? || attribute.to_s.empty? || attribute == 0
    end

    def validate_format(attribute, format)
      raise  ValidationError, 'Неверный формат значения' if attribute !~ format
    end

    def validate_type(attribute, class_of)
      raise  ValidationError, 'Не подходящий класс объекта' unless attribute.is_a?(class_of)
    end
  end
end
