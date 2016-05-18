class Route
  def initialize
    @route = []
  end

  def add_station!(station)
    route.push(station)
    puts "Station '#{station.to_s.capitalize}' successfully added to route."
  end

  def remove_station!(station)
    route.delete(station)
    puts "Station '#{station.to_s.capitalize}' successfully removed from route."
  end

  def copy_route
    route.map {|station| station}
  end

  def all_stations
    route.each_with_index do |station, index|
      puts "Destination point #{index + 1} is #{station.to_s.capitalize}"
    end
  end

  def departure_station
    route.first
  end

  def destination_station
    route.last
  end

  private

  attr_accessor :route
end
