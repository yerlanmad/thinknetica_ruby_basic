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
    stations.delete(station) unless [stations.first, stations.last].include?(station)
  end

  def stations_name
    stations.map(&:name)
  end
end
