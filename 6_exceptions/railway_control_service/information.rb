class Information
  attr_accessor :train, :station

  def initialize
    @train = Hash.new
    @station = Hash.new
  end

  def trains
    train.keys.join(", ")
  end

  def validate_unique_number?(number)
    raise 'You already have the train with that number!' if train.keys.any? {|train_number| train_number == number}
    true
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
