class Train
  TRAIN_NUMBER_FORMAT = /^([a-z]{3}|\d{3})-?([a-z]{2}|\d{2})$/i

  include Text
  include Company
  include InstanceCounter

  attr_reader :carriages, :type, :station, :number, :speed, :route
  attr_accessor :on_station

  def self.information=(information)
    @@information = information
  end

  def initialize(number)
    @@information ||= nil
    @number = number
    @on_station = false
    @carriages = []
    @speed = 0
    information = @@information
    valid!
    information.validate_unique_number?(number)
    information.train[@number] = self
  end

  def go(speed)
    self.speed = speed
  end

  def speed_up
    self.speed += 10
  end

  def speed_down
    self.speed -= 10
  end

  def unhook
    carriages.pop
  end

  def attach
    carriages.push @carriage.new
  end

  # def route!(route)
  #   self.route = route.copy_list
  #   self.station = self.route.first
  # end

  # def route_last
  #   puts Text.message(:train, :route_last) + route.last_station.to_s
  # end

  # def route_first
  #   puts Text.message(:train, :route_first) + route.first_station.to_s
  # end

  # def move!
  #   if !on_station && !next_station
  #     self.station = next_station
  #     speed = 0
  #   else
  #     puts Text.message(:train, :error_move)
  #   end
  # end

  def next_station
    next_index = route.index(station) + 1
    route[next_index]
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

  def each_carriage(&block)
    carriages.each do |carriage|
      block.call(carriage)
    end
  end

  def length
    carriages.length
  end

  protected

  attr_reader :information
  attr_writer :speed, :route, :station

  def valid!
    valid_number!
    valid_information!
    valid_speed_parameter!
    valid_on_station_parameter!
    valid_type_parameter!
    fail 'Not valid type parameter!' if type == :passenger || type == :cargo
    true
  end

  def valid_number!
    fail 'Not valid train number!' if number.to_s !~ TRAIN_NUMBER_FORMAT
  end

  def valid_information!
    fail 'Information class is nil!' if @@information.nil?
    fail 'Not valid information object!' unless @@information.class == DataCenter
  end

  def valid_speed_parameter!
    fail 'Not valid speed parameter!' if speed < 0
  end

  def valid_on_station_parameter!
    fail 'Not valid on_station parameter!' unless on_station_boolean?
  end

  def on_station_boolean?
    !!on_station == on_station
  end

  def valid_type_parameter!
    fail 'Not valid type parameter!' if type == :passenger || type == :cargo
  end
end
