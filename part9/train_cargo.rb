require_relative 'train'

class CargoTrain < Train
  @trains = {}

  def add_wagon(wagon)
    return unless wagon.is_a? CargoWagon

    super
  end
end
