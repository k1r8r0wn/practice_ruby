require_relative 'text'
require_relative 'company'
require_relative 'information'
require_relative 'train'
require_relative 'cargo_carriage'

class CargoTrain < Train
  def initialize(number)
    super
    @type = :cargo
    @carriage_type = CargoCarriage
  end
end

# @information = Information.new
# Train.information = @information
# cargo = CargoTrain.new("aaa-12".to_sym)
# p cargo.valid?
