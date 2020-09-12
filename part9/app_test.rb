class AppTest
  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  def call
    create_stations(7)
    create_trains(5)
    create_routes(3)
    add_wagons
    accept_route
    log
  end

  private

  attr_reader :stations, :routes, :trains

  def create_stations(count)
    count.times do |n|
      stations << Station.new("station_00#{n}")
    end
  end

  def create_trains(count)
    count.times do |n|
      trains << PassengerTrain.new("10P-0#{n}")
      trains << CargoTrain.new("20C-0#{n}")
    end
  end

  def create_routes(count)
    count.times do
      routes << Route.new(stations.sample, stations.sample)
    end
  end

  def accept_route
    trains.each { |train| train.accept(routes.sample) }
  end

  def add_wagons
    trains.each do |train|
      if train.class == PassengerTrain
        10.times { train.add_wagon(PassengerWagon.new(40)) }
        train.each_wagon { |wagon| rand(40).times { wagon.occupy } }
      else
        7.times { train.add_wagon(CargoWagon.new(10_000)) }
        train.each_wagon { |wagon| wagon.occupy(rand(10_000)) }
      end
    end
  end

  def log
    stations.each do |station|
      puts "Station:#{station.name}"
      station.each_train do |train|
        puts "Train: #{train.number}, #{train.class}, #{train.wagons.size}"
        display_wagons(train)
        puts
      end
    end
  end

  def display_wagons(train)
    puts 'Wagons:'
    train.each_wagon do |wagon, number|
      puts "#{number}, #{wagon.class}, #{wagon.occupied}, #{wagon.empty_place}"
    end
  end
end
