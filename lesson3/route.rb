class Route
  attr_reader :name, :stations

  def initialize(first_station, last_station)
    @name = "#{first_station.name} - #{last_station.name}"
    @stations = [first_station, last_station]
  end

  def add(station)
    stations.insert(-2, station) unless stations.include?(station)
  end

  def remove(station)
    stations.delete(station) unless [0, -1].any?{ |i| stations[i] == station }
  end
end
