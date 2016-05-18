class Route
  attr_accessor :route

  def initialize
    @route = []
  end

  def add_station(station)
    route.push(station)
    puts "Station '#{station}' successfully added to route."
  end

  def remove_station(station)
    route.delete(station)
    puts "Station '#{station}' successfully removed from route."
  end

  def all_stations
    route
  end

  def departure_station
    route.first
  end

  def destination_station
    route.last
  end
end
