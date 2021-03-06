class Train
  attr_reader :number, :speed, :station, :route, :carriage_type, :carriages
  attr_accessor :on_station, :type

  def initialize(number)
    @number = number
    @on_station = false
    @type = :universal
    @speed = 0
    @carriage_type = :universal
    @carriages = []
    @information = @@information
    @information[:train].push(self)
  end

  def self.information= (information)
    @@information = information
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
    self.carriages.push @carriage_type.new if speed_zero?
  end

  def unhook_carriage
    self.carriages.pop if speed_zero? && ready_to_unhook?
  end

  def route!(route)
    self.route = route.copy_route
    self.station = self.route.departure_station
  end

  def train_departure_station
    puts "The departure station in a route of the train №#{number} is #{route.departure_station.capitalize}."
  end

  def train_destination_station
    puts "The destination station in a route of the train №#{number} is #{route.destination_station.capitalize}."
  end

  def move!
    self.station = next_station unless on_station && next_station
    speed = 0
  end

  def all_trains
    "Train number: #{number}, type: #{type} train, length: #{length} carriage(-s), current speed: #{speed} km/h."
  end

  def print_train_number
    number.to_s
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

  def ready_to_unhook?
    self.speed.zero? && length > 0
  end

  def next_station
    next_station = route.index(@station) + 1
    route[next_station]
  end

  def length
    carriages.size
  end
end
