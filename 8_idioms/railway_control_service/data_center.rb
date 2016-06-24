class DataCenter
  attr_accessor :train, :station
  
  def initialize
    @train = {}
    @station = {}
    RailwayStation.information = self
    Train.information = self
  end

  def initialize_train(type, new_train_number)
    if type == :cargo
      CargoTrain.new(new_train_number)
    elsif type == :passenger
      PassengerTrain.new(new_train_number)
    else
      fail 'Wrong type of train!'
    end
  end

  def trains_list
    train.keys.join(', ')
  end

  def trains_list_expanded
    message = train.values.map do |train|
      text = Text.message(:train, :info)
      "#{text[0]}: #{train.number} #{text[1]}: #{train.type}
      \t#{text[2]}: #{train.length} #{text[3]}: #{train.speed}"
    end
    message.join("\n") + "\n"
  end

  def trains_to_allow
    trains_list = train.select { |_, train| !train.on_station }
    fail 'No trains available to allow to the stations' if trains_list.empty?
    trains_list.keys.join(', ')
  end

  def ready_to_unhook
    ready_trains = train.select do |_, train_obj|
      first = train_obj.on_station == true && train_obj.speed == 0
      first && !train_obj.carriages.empty?
    end
    fail 'Error, there is no trains to unhook carriages!' if ready_trains.empty?
    ready_trains.keys.join(', ')
  end

  def ready_to_hook
    ready_trains = train.select do |_, train_obj|
      train_obj.on_station == true && train_obj.speed == 0
    end
    fail 'Error, there is no trains to hook carriages!' if ready_trains.empty?
    ready_trains.keys.join(', ')
  end

  def validate_unique_number?(number)
    if train.keys.any? { |train_number| train_number == number }
      fail 'You already have that train number!'
    end
    true
  end

  def stations_list
    "Station list: #{station.keys.join('; ')}"
  end

  def trains_list_to_s
    if train.empty?
      Text.menu(:no_train)
    else
      "#{Text.menu(:list_trains)} \n\n#{trains_list_expanded}\n"
    end
  end

  def initialize_station(new_station_name)
    RailwayStation.new(new_station_name)
  end

  def print_station(station)
    text = Text.message(:station, :info)
    "#{text[0]}: #{station.name_station},
      #{text[1]}: #{station.train_list.length} (#{station.train_names}),
      #{text[2]}: #{station.trains_calc[:cargo]}
      #{text[3]}: #{station.trains_calc[:passenger]}"
  end

  def stations_list_to_s
    if station.empty?
      Text.menu(:no_station)
    else
      message = station.values.map do |station|
        print_station(station)
      end
      message = message.join("\n\n") + "\n"
      "#{Text.menu(:list_stations)} \n\n#{message}\n"
    end
  end

  def allow_arrival(station_name, train_number)
    station_obj = get_and_find_obj(:station, station_name)
    train_obj = get_and_find_obj(:train, train_number)
    station_obj.allow_arrival! train_obj
  end

  def get_and_find_obj(type, name)
    method = type == :train ? 'train' : 'station'
    hash = send(method)
    fail "error, no \"#{name}\" #{type}" if hash[name].nil?
    hash[name]
  end

  def unhook(name)
    get_and_find_obj(:train, name).unhook
  end

  def attach(name)
    get_and_find_obj(:train, name).attach
  end
end
