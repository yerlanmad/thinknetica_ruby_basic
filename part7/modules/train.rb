# frozen_string_literal: true

class Train
  include Manufacturer
  include InstanceCounter
  include Validatable
  include Logable
  MAX_CARS = 30
  MIN_CARS = 1

  class << self
    attr_accessor :trains

    def find(number)
      trains.find { |train| train.number == number }
    end
  end

  attr_reader :number, :type, :rail_cars, :current_speed

  def initialize(number)
    @number = number
    @rail_cars = []
    @current_speed = 0
    validate
    return unless valid?

    log
    add_train
    register_instance
  end

  def add_train
    self.class.trains ||= []
    self.class.trains << self
  end

  def attach_car(car)
    return if current_speed.positive? || rail_cars.size >= MAX_CARS

    rail_cars << car
  end

  def detach_car
    return if current_speed.positive? || rail_cars.size < MIN_CARS

    rail_cars.pop
  end

  def accept_route(route)
    @route = route
    @current_station_index = 0
    current_station.accept_train(self)
    log
  end

  def travel_forward
    return unless next_station

    current_station.remove_train(self)
    next_station.accept_train(self)
    self.current_station_index += 1
    log
  end

  def travel_backward
    return unless previous_station

    current_station.remove_train(self)
    previous_station.accept_train(self)
    self.current_station_index -= 1
    log
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

  def cars_amount
    rail_cars.size
  end

  def speed_up
    @current_speed += 10
  end

  def stop_train
    @current_speed = 0
  end

  def name
    "#{number}(#{type})"
  end

  def each_rail_car
    return unless block_given?

    rail_cars.each_with_index do |car, index|
      yield(car, index)
    end
  end

  protected

  attr_accessor :current_station_index, :route

  def log
    data = "Train: #{number}, " \
           "current station: #{current_station&.name}, " \
           "route: #{route&.name}"
    write_log(data)
  end

  def validate
    super(number)
  rescue AttributeSizeError, AttributePresentError => e
    write_error(e.message)
    self.valid = false
  else
    self.valid = true
  end
end
