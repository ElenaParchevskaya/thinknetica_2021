module Validation
  def self.validate(name, type, *args)
    public_send("validate_#{type}".to_sym, name, args)
  end

  def self.validate_presence(name, args)
    name && name != ''
  end

  def self.validate_format(name, args)
    format = args[0]
    name =~ format
  end

  def self.validate_type(name, args)
    name.class = args[0]
  end

  def validate!(name, type, *args)
    Validation.validate(name, type, *args)
  end
end
