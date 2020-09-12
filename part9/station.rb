class Station
  include InstanceCounter
  include Validatable

  attr_reader :name

  @stations = []

  class << self
    attr_reader :stations

    def all
      @stations
    end
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!

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

  def each_train
    return unless block_given?

    trains.each { |train| yield(train) }
  end

  private

  def validate!
    raise 'Name can not be empty' unless present?(name)
    raise 'Name size error' unless valid_size?(name)
  end
end
