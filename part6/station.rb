class Station
  include InstanceCounter
  @stations = []

  class << self
    attr_reader :stations

    def all
      @stations
    end
  end

  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
    self.class.stations << self
  end

  def accept(train)
    @trains << train
  end

  def trains(type = nil)
    return @trains unless type

    case type
    when 'passenger'
      @trains.select { |train| train.is_a? PassengerTrain }
    when 'cargo'
      @trains.select { |train| train.is_a? CargoTrain }
    end
  end

  def send(train)
    @trains.delete(train)
  end

  def trains_name
    @trains.map(&:name).join(', ')
  end
end
