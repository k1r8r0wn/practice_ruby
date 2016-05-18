require_relative 'passenger_carriage'

class PassengerTrain < Train
  def initialize(number)
    super
    @type = :passenger
    @carriage_type = PassengerCarriage
  end
end
