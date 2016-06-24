# Route class
class Route
  def initialize
    @route = []
  end

  def add_station!(station)
    fail 'Not a station class object!' unless station.class == RailwayStation
    route.push(station)
  end

  def remove_station!(station)
    route.delete(station)
  end

  def copy_list
    route.map { |station| station }
  end

  def list
    route.each do |station, index|
      "Destination point \# #{index + 1} is #{station.to_s.capitalize}"
    end
  end

  def last_station
    route.last
  end

  def first_station
    route.first
  end

  private

  attr_reader :route
end
