require_relative 'cargo_carriage'

class CargoTrain < Train
  def initialize(number)
    super
    @type = :cargo
    @carriage_type = CargoCarriage
  end
end
