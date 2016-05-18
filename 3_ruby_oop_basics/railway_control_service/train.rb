class Train
  attr_reader :number, :type, :length
  attr_accessor :speed, :route, :on_station

  def initialize(number, type, length)
    @number = number
    @type = type
    @length = length
    @speed = 0
    puts "Add new train №#{number}, with a #{type} type and #{length} carriage(-s)."
  end

  def current_speed
    if @speed > 0
      puts "Train №#{number} has speed #{@speed} km/h."
    else
      puts "Train №#{number} is not moving."
    end
  end

  def speed_up
    @speed += 20
    if speed_zero?
      puts "Train №#{number} started to move with 20 km/h speed."
    else
      puts "Speed of the train №#{number} was raised by 20 km/h and now is #{@speed} km/h."
    end
  end

  def speed_down
    @speed -= 20
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

  def train_length
    puts "Train №#{number} has #{length} carriage(-s)."
  end

  def hook_carriage
    if speed_zero?
      @length += 1
      puts "Train №#{number} hooks new carriage, now it has #{length} carriages."
    else
      puts "You need to stop train №#{number} before!"
    end
  end

  def unhook_carriage
    if speed_zero?
      @length -= 1
      puts "Train №#{number} unhooks one carriage, now it has #{length} carriages."
    else
      puts "You need to stop train №#{number} before!"
    end
  end

  def route!(route)
    @route = route.all_stations
    @station = route.departure_station
    puts "The train №#{number} has received a new route #{@route}."
  end

  def train_departure_station
    puts "The departure station in a route of the train №#{number} is #{route.first.capitalize}."
  end

  def train_destination_station
    puts "The destination station in a route of the train №#{number} is #{route.last.capitalize}."
  end

  def move!
    unless @on_station == true & next_station
      @station = next_station
      speed = 0
      puts "The train №#{number} has arrived on the station #{@station.capitalize}."
    else
      puts "The train №#{number} can't move. You haven't got a permition to move or you're on a final staion of your route. You need to get allow to departure in the #{@station.capitalize} station first, or get new route."
    end
  end

  private

  def speed_zero?
    @speed.zero?
  end

  def speed_negative?
    @speed < 0
  end

  def next_station
    next_station = route.index(@station) + 1
    route[next_station]
  end
end
