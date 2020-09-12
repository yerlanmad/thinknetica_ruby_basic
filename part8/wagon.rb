class Wagon
  include Manufacturer

  attr_reader :capacity, :occupied

  def initialize(capacity)
    @capacity = capacity
    @occupied = 0
  end

  def occupy(amount = 1)
    @occupied += amount if (occupied + amount) <= capacity
  end

  def empty_place
    capacity - occupied
  end
end
