require_relative 'company'
require_relative 'information'
require_relative 'text'

class Train
  include Text
  include Company

  TRAIN_NUMBER_FORMAT = /^([a-z]|\d){3}-?([a-z]|\d){2}$/i

  attr_reader :number, :speed, :station, :route, :type, :carriages
  attr_accessor :on_station

  def initialize(number)
    @information ||= nil
    @number = number
    @on_station = false
    @type = :universal
    @speed = 0
    @carriage_type = :universal
    @carriages = []
    @information = @@information
    valid!
    @information.validate_unique_number?(number)
    @information.train[@number]= self
  end

  def self.information= (information)
    @@information = information
  end

  def self.find(number)
    number = number.to_sym
    @@information.train[number] || nil
  end

  def valid?
    valid!
  rescue StandardError
    false
  end

  def current_speed
    if @speed > 0
      puts "Train №#{number} has speed #{@speed} km/h."
    else
      puts "Train №#{number} is not moving."
    end
  end

  def speed_up
    self.speed += 20
    if speed_zero?
      puts "Train №#{number} started to move with 20 km/h speed."
    else
      puts "Speed of the train №#{number} was raised by 20 km/h and now is #{@speed} km/h."
    end
  end

  def speed_down
    self.speed -= 20
    if speed_zero? || speed_negative?
      puts "Train №#{number} already stopped, raise the speed."
    else
      puts "Speed of the train №#{number} was lowered by 20 km/h and now is #{@speed} km/h."
    end
  end

  def stop
    if speed_zero?
      puts "Train №#{number} already stopped."
    else
      @speed = 0
      puts "Train №#{number} stopped."
    end
  end

  def hook_carriage
    raise 'Train not ready to hook carriages' unless on_station && speed == 0
    self.carriages.push @carriage_type.new
    raise 'Error with carriages!' unless carriages.any? { |carriage| carriage.class == @carriage_type }
  end

  def unhook_carriage
    raise 'Train not ready to unhook carriages.' unless on_station && speed == 0 && !carriages.empty?
    self.carriages.pop
  end

  def route!(route)
    self.route = route.copy_route
    self.station = self.route.departure_station
  end

  def train_departure_station
    puts Text.message(:train, :departure_station) + route.departure_station.capitalize
  end

  def train_destination_station
    puts Text.message(:train, :destination_station) + route.last.destination_station.capitalize
  end

  def move!
    if !on_station && !next_station
      self.station = next_station
      @speed = 0
    else
      puts Text.message(:train, :move_error)
    end
  end

  def next_station
    next_station = route.index(station) + 1
    route[next_station]
  end

  def all_trains
    "Train number: #{number}, type: #{type} train, length: #{length} carriage(-s), current speed: #{speed} km/h."
  end

  def print_train_number
    number.to_s
  end

  def each_carriage(&block)
    carriages.each do |carriage|
      block.call(carriage)
    end
  end

  private

  attr_reader :information
  attr_writer :speed, :route, :station

  def speed_zero?
    self.speed.zero?
  end

  def speed_negative?
    self.speed < 0
  end

  def length
    carriages.size
  end

  def valid!
    raise 'Not valid train number!' if number.to_s !~ TRAIN_NUMBER_FORMAT
    raise 'Information class is nil!' if @@information.nil?
    raise 'Not valid registry object!' unless @@information.class == Information
    raise 'Not valid speed parameter!' if speed < 0
    raise 'Not valid on_station parameter!' if on_station == (false || true)
    raise 'Not valid type parameter!' if type == (:passenger || :cargo)
    true
  end
end

# information = Information.new
# Train.information = information
# cargo = Train.new(:cargo_13)
# Train.new(:passenger_7)
#
# puts cargo.name= ('Chicago Railway Manufacture')
# puts cargo.produced_by('train')
#
# Train.find(:cargo_13).current_speed
