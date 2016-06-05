require_relative 'information'

class RailwayStation
  attr_reader :name, :trains

  INITIAL_TRAIN_SPEED = 50

  def initialize(name)
    @@information ||= nil
    @name = name
    @trains = []
    @information = @@information
    @information.station[@name]= self
    valid!
  end

  def self.information= (information)
    @@information = information
  end

  def self.all_stations
    puts @@information.station.keys
  end

  def valid?
    valid!
  rescue StandardError
    false
  end

  def trains_at_station
    if trains.length > 0
      "Station name: #{print_station_name}, Train(-s) in the station: #{trains.length} (#{trains_numbers}), Cargo train(-s): #{trains_calc[:cargo]}, Passenger train(-s): #{trains_calc[:passenger]}"
    else
      "No trains at the #{print_station_name} station now."
    end
  end

  def allow_arrival!(train)
    train.on_station = true
    trains.push(train)
  end

  def allow_departure!(train)
    train.on_station = false
    train.speed = INITIAL_TRAIN_SPEED
    trains.delete(train)
  end

  def print_station_name
    name.to_s.capitalize
  end

  private

  attr_reader :information
  attr_writer :trains

  def trains_calc
    cargo, passenger = [0, 0]
    trains.each do |train|
      cargo += 1 if train.type == :cargo
      passenger += 1 if train.type == :passenger
    end
  {cargo: cargo, passenger: passenger}
  end

  def trains_numbers
    numbers = trains.map do |train|
      train.number
    end
    numbers.join(", ")
  end

  def valid!
    raise 'Information class is nil!' if @information.nil?
    raise 'Not valid information object!' unless @information.class == Information
    raise 'Some error with station name!' if name.nil? || name.class != Symbol || name.length > 100
    raise 'Some error with train list!' if trains.any? {|train| train.class != Train}
    true
  end
end

# information = Information.new
# RailwayStation.information = information
#
# RailwayStation.new(:Berlin)
# paris = RailwayStation.new(:Paris)
# RailwayStation.all_stations
# p information.station

# p paris.valid?
