class Train
  include Manufacturer
  include InstanceCounter
  include Accessors
  include Validation

  NUMBER_FORMAT = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i.freeze

  attr_reader :number, :wagons, :speed

  attr_accessor_with_history :driver
  strong_attr_accessor :build_date, Time

  validate :number, :presence
  validate :number, :type, String
  validate :number, :format, NUMBER_FORMAT

  validate :wagons, :presence
  validate :wagons, :type, Array

  validate :speed, :presence
  validate :speed, :type, Numeric

  @trains = {}

  class << self
    attr_reader :trains

    def find(number)
      @trains[number]
    end
  end

  def initialize(number)
    @number = number
    @wagons = []
    @speed = 0
    validate!

    self.class.trains[number] = self
    register_instance
  end

  def speed_up
    @speed += 10
  end

  def stop
    @speed = 0
  end

  def add_wagon(wagon)
    wagons << wagon if speed.zero?
  end

  def remove_wagon
    wagons.pop if speed.zero?
  end

  def accept(route)
    @route = route
    @current_station_index = 0
    current_station.accept(self)
  end

  def forward
    return unless next_station

    current_station.send_train(self)
    next_station.accept(self)
    self.current_station_index += 1
  end

  def backward
    return unless previous_station

    current_station.send_train(self)
    previous_station.accept(self)
    self.current_station_index -= 1
  end

  def current_station
    return unless route

    route.stations[current_station_index]
  end

  def previous_station
    return unless route
    return unless current_station_index.positive?

    route.stations[current_station_index - 1]
  end

  def next_station
    return unless route

    route.stations[current_station_index + 1]
  end

  def name
    "#{number}(#{self.class})"
  end

  def each_wagon
    return unless block_given?

    wagons.each.with_index(1) { |wagon, num| yield(wagon, num) }
  end

  protected

  attr_accessor :current_station_index
  attr_reader :route
end
