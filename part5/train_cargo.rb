require_relative 'train'

class CargoTrain < Train
  def initialize(number)
    super
    @type = 'cargo'
  end

  def add_wagon(wagon)
    return unless wagon.is_a? CargoWagon

    super
  end
end
