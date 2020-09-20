class Station
  include InstanceCounter
  include Accessors
  include Validation

  attr_accessor :name

  attr_accessor_with_history :director
  strong_attr_accessor :build_date, Time

  validate :name, :presence
  validate :name, :type, String
  validate :name, :format, /^[\w\s]{3,32}$/

  validate :trains, :presence
  validate :trains, :type, Array

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

  def send_train(train)
    @trains.delete(train)
  end

  def trains_name
    @trains.map(&:name).join(', ')
  end

  def each_train
    return unless block_given?

    trains.each { |train| yield(train) }
  end
end
