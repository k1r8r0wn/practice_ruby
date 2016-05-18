class Information
  attr_accessor :train, :station

  def initialize
    @train = Hash.new
    @station = Hash.new
  end

  def trains
    train.keys.join(", ")
  end

  def trains_available_to_hook_and_unhook_carriages
    trains = train.values.each.find_all do |train|
      train.on_station == true && train.speed == 0
    end
    trains.map! {|train| train.number.to_s}
    message = !trains.empty? ? trains.join(", ") : Text.message(:system, :no_trains)
    "Available train(s) at station: #{message}"
  end

  def trains_available_to_allow
    trains = train.values.each.find_all do |train|
      train.on_station == false
    end
    trains.map! {|train| train.number}
    message = !trains.empty? ? trains.join(", ") : Text.message(:system, :no_trains)
    "Available train(-s) to allow: #{message}"
  end

  def trains_expanded
    trains = train.values.map do |train|
      train.all_trains
    end
    trains.join("\n")
  end

  def stations
    station.keys.join("\n")
  end

  def stations_expanded
    stations = station.values.map do |station|
      station.trains_at_station
    end
    stations.join("\n")
  end
end
