require_relative 'wagon'

class CargoWagon
  attr_reader :capacity, :occupied_volume

  def initialize(capacity)
    @capacity = capacity
    @occupied_volume = 0
  end

  def fill(volume)
    @occupied_volume += volume if (occupied_volume + volume) <= capacity
  end

  def empty_volume
    capacity - occupied_volume
  end
end
