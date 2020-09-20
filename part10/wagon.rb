class Wagon
  include Manufacturer
  include Validation

  attr_reader :capacity, :occupied

  validate :capacity, :presence
  validate :capacity, :type, Numeric

  validate :occupied, :presence
  validate :occupied, :type, Numeric

  def initialize(capacity)
    @capacity = capacity
    @occupied = 0
    validate!
  end

  def occupy(amount = 1)
    @occupied += amount if (occupied + amount) <= capacity
  end

  def empty_place
    capacity - occupied
  end
end
