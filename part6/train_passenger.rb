require_relative 'train'

class PassengerTrain < Train
  @trains = []

  def initialize(number)
    super
    @type = 'passenger'
  end

  def add_wagon(wagon)
    return unless wagon.is_a? PassengerWagon

    super
  end
end
