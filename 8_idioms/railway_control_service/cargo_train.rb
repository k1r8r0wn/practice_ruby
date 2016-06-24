class CargoTrain < Train
  def initialize(number)
    super
    @type = :cargo
    @carriage = CargoCarriage
  end
end
