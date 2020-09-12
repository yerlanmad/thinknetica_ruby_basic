class Train
  include Manufacturer
  include InstanceCounter
  include Validatable
  @trains = {}
  NUMBER_FORMAT = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i

  class << self
    attr_reader :trains

    def find(number)
      @trains[number]
    end
  end

  attr_reader :number, :wagons, :speed

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

    current_station.send(self)
    next_station.accept(self)
    self.current_station_index += 1
  end

  def backward
    return unless previous_station

    current_station.send(self)
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

  def validate!
    raise 'Number can not be empty' unless present?(number)
    raise 'Number has invalid format' if number !~ NUMBER_FORMAT
  end
end
