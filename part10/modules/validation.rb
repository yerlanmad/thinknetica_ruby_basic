module Validation
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(attribute, method, param = nil)
      @validations ||= Hash.new { |hsh, key| hsh[key] = [] }
      @validations[attribute] << { method => param }
    end
  end

  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end

  private

  def validate!
    self.class.validations.each do |attribute, actions|
      value = instance_variable_get("@#{attribute}".to_sym)
      actions.each do |action|
        action.each { |method, param| send(method, value: value, param: param) }
      end
    end
  end

  def presence(**opts)
    raise 'Attribute can not be empty' if opts[:value].nil? || opts[:value].to_s.empty?
  end

  def format(**opts)
    raise 'Attribute has invalid format' if opts[:value] !~ opts[:param]
  end

  def type(**opts)
    raise 'Attribue has invalid type' unless opts[:value].is_a? opts[:param]
  end
end
