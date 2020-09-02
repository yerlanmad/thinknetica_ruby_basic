class Station
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def accept(train)
    @trains << train
  end

  def trains(type = nil)
    return @trains unless type

    @trains.select { |train| train.type == type }
  end

  def send(train, station)
    @trains.delete(train)
    station.accept(train)
  end
end
