module Validatable
  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end

  private

  def present?(attribute)
    !(attribute.nil? || attribute == '' || attribute == 0 || attribute == [])
  end

  def valid_size?(attribute)
    (3..64).include?(attribute.size)
  end
end
