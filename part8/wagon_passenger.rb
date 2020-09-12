require_relative 'wagon'

class PassengerWagon
  attr_accessor :seats, :occupied_seats
  
  def initialize(seats)
    @seats = seats
    @occupied_seats = 0
  end

  def take_place
    @occupied_seats += 1 if occupied_seats < seats
  end

  def empty_seats
    seats - occupied_seats
  end
end
