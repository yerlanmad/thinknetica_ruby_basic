class Route
  include InstanceCounter
  include Validation

  attr_reader :name, :stations

  validate :name, :presence
  validate :name, :type, String
  validate :name, :format, /^[\w\s]{3,32}\s-\s[\w\s]{3,32}$/

  validate :stations, :presence
  validate :stations, :type, Array

  def initialize(first_station, last_station)
    @name = "#{first_station.name} - #{last_station.name}"
    @stations = [first_station, last_station]
    validate!
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
