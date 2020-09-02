class Train
  attr_reader :number, :type, :wagons_amount, :speed
  attr_accessor :current_station, :route
  
  def initialize(number, type, wagons_amount = 0)
    @number = number
    @type = type
    @wagons_amount = wagons_amount
    @speed = 0
  end

  def speed_up
    @speed += 10
  end

  def stop
    @speed = 0
  end
  
  def add_wagon
    @wagons_amount += 1
  end

  def remove_wagon
    @wagons_amount -= 1 if wagons_amount > 0
  end

  def accept(route)
    @route = route
    @current_station_index = 0
    current_station.accept(self)
  end

  def forward
    return unless next_station

    current_station.send(self, next_station)
    @current_station_index += 1
  end

  def backward
    return unless previous_station

    current_station.send(self, previous_station)
    @current_station_index -= 1
  end

  def current_station
    return unless route

    route.stations[@current_station_index]
  end

  def previous_station
    return unless route
    return unless @current_station_index.positive?

    route.stations[@current_station_index - 1]
  end

  def next_station
    return unless route

    route.stations[@current_station_index + 1]
  end
end
