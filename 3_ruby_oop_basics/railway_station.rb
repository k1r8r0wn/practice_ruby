# Жедезнодорожная станция.

# Имеет название, которое указывается при ее создании;
# Может показывать список всех поездов на станции, находящиеся в текущий момент;
# Может показывать список поездов на станции по типу: кол-во грузовых, пассажирских;
# Может принимать поезда;
# Может отправлять поезда (при этом, поезд удаляется из списка поездов, находящихся на станции).

class RailwayStation
  attr_accessor :name, :trains

  def initialize(name)
    @name = name
    @trains = []
    puts "Station #{name.capitalize} created!"
  end

  def trains_at_station
    if trains_calc == [0, 0]
      puts "No trains at the #{name.capitalize} station now."
    else
      puts "There are(is): #{trains_calc[0]} Cargo train(-s) & #{trains_calc[1]} Passenger train(-s) at the #{name.capitalize} station"
    end
  end

  def allow_arrival!(train)
    train.on_station = true
    train.stop
    trains.push(train)
    puts "The train №#{train.number} arrived to the #{name.capitalize} station."
  end

  def allow_departure!(train)
    train.on_station = false
    train.speed = 50
    trains.delete(train)
    puts "Station #{name.capitalize} allow the train №#{train.number} to derparture."
  end

  private

  def trains_calc
    cargo, passenger = [0, 0]
    trains.each do |train|
      cargo += 1 if train.type == :cargo
      passenger += 1 if train.type == :passenger
    end
  [cargo, passenger]
  end
end
