class Route
  include InstanceCounter
  include Validatable

  attr_reader :name, :stations

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

  private

  def validate!
    raise 'Stations present error' unless present?(stations.first) && present?(stations.last)
    raise 'First and Last stations should be different' if stations.first == stations.last
    raise 'Name length error' unless valid_size?(name)
  end
end
