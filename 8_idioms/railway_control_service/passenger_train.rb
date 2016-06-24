class PassengerTrain < Train
  def initialize(number)
    super
    @type = :passenger
    @carriage = PassengerCarriage
  end
end
