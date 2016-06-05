require_relative 'railway_control_service/information'
require_relative 'railway_control_service/railway_station'
require_relative 'railway_control_service/train'
require_relative 'railway_control_service/route'
require_relative 'railway_control_service/passenger_train'
require_relative 'railway_control_service/cargo_train'
require_relative 'railway_control_service/carriage'
require_relative 'railway_control_service/text'

class Main
  include Text

  def initialize
    @information = Information.new
    RailwayStation.information = @information
    Train.information = @information

    RailwayStation.new :Paris
    RailwayStation.new :Berlin
    RailwayStation.new :Prague
    moscow = RailwayStation.new :Moscow

    cargo = CargoTrain.new('CAR-12'.to_sym)
    moscow.allow_arrival! cargo
    PassengerTrain.new('PAS-70'.to_sym)
  end

  def interface
    begin
      catch (:exit) do
        loop do
          menu
          first_command = command
          throw :exit if first_command == 'q'
          case first_command
          when 's'
            menu_option('menu_create_station')
          when 'ct'
            menu_option('menu_create_cargo_train')
          when 'pt'
            menu_option('menu_create_passenger_train')
          when 'h'
            menu_option('menu_hook_carriage')
          when 'un'
            menu_option('menu_unhook_carriage')
          when 'a'
            menu_option('menu_allow_arrival')
          when 'i'
            menu_option('menu_information')
          else
            menu_option('menu_error')
          end
        end
      end

      rescue StandardError => e
        attempt ||= 0
        attempt += 1
        if attempt < 3
          puts e.message
          # puts e.backtrace
          puts 'You made an error, try again!'
          pause
          retry
        end
        raise 'Too much errors here, sorry... bye, bye!'
    end
  end

  private

  attr_reader :information, :rescue_count

  def menu
    system('clear')
    puts Text.intro_message(:menu)
  end

  def menu_option(option)
    system('clear')
    puts Text.intro_message(option.to_sym)
    send option
    if resulting_option?(option) && (option != ('menu_error')) && (option != ('menu_information'))
      puts Text.system_message(:success)
    end
    pause
  end

  def command
    puts Text.message(:enter, :command)
    gets.chomp.downcase
  end

  def menu_error; end

  def pause
    puts Text.system_message(:pause)
    gets
  end

  def resulting_option?(option)
    option = 'menu_create_station' || 'menu_create_cargo_train' || 'menu_create_passenger_train' || 'menu_hook_carriage' || 'menu_unhook_carriage'|| 'menu_allow_arrival'
  end

  def menu_create_station
    name = gets.chomp.to_sym
    nil_validation?(name)
    RailwayStation.new(name)
  end

  def menu_create_cargo_train
    number = gets.chomp.to_sym
    nil_validation?(number)
    CargoTrain.new(number)
  end

  def menu_create_passenger_train
    number = gets.chomp.to_sym
    nil_validation?(number)
    PassengerTrain.new(number)
  end

  def menu_hook_carriage
    trains = information.train.select { |_, train| train.on_station == true && train.speed == 0 }
    raise 'You need to allow any train to any station first!' if trains.empty?
    trains = trains.keys.join(", ")
    puts "Available train(-s) on station: #{trains}, enter train number, please:"
    train = get_and_find(:train)
    train.hook_carriage
  end

  def menu_unhook_carriage
    trains = information.train.select {|_, train| train.on_station == true && train.speed == 0 && !train.carriages.empty?}
    raise 'You need to allow any train to any station first or your existing train(-s) have no carriages at all.' if trains.empty?
    trains = trains.keys.join(", ")
    puts "Available train(-s) on station: #{trains}, enter train number, please:"
    train = get_and_find(:train)
    train.unhook_carriage
  end

  def menu_allow_arrival
    puts information.stations
    puts 'Enter the station name, please:'
    station = get_and_find(:station)
    trains_available_to_allow
    puts 'Enter the train number, please:'
    train = get_and_find(:train)
    station.allow_arrival! train
    puts "Great! Now train №#{train.print_train_number} is at #{station.print_station_name} station."
  end

  def trains_available_to_allow
    trains = information.train.select {|_,train| !train.on_station}
    raise 'No trains available to allow now.' if trains.empty?
    puts "List of trains available to allow: #{trains.keys.join(", ")}"
  end

  def menu_information
    if information.train.empty? && information.station.empty?
      puts '---------------------------------'
      puts 'No stations & trains yet.'
      puts '---------------------------------'
    elsif information.station.empty?
      puts '---------------------------------'
      puts 'No stations yet.'
      puts '---------------------------------'
      puts 'List of all available trains:'
      puts '---------------------------------'
      puts "#{information.trains_expanded}"
    elsif information.train.empty?
      puts '---------------------------------'
      puts 'List of all available stations:'
      puts '---------------------------------'
      puts "#{information.stations}"
      puts '---------------------------------'
      puts 'No trains yet.'
      puts '---------------------------------'
    else
      puts '---------------------------------'
      puts 'List of all available stations:'
      puts '---------------------------------'
      puts "#{information.stations}"
      puts '---------------------------------'
      puts 'List of all available trains:'
      puts '---------------------------------'
      puts "#{information.trains_expanded}"
      puts '---------------------------------'
      puts 'Trains at stations:'
      puts '---------------------------------'
      puts "#{information.stations_expanded}"
      puts '---------------------------------'
    end
  end

  def get_and_find(type)
    name = gets.chomp.to_sym
    nil_validation?(name)
    method = type == :train ? 'train' : 'station'
    hash = information.send method
    raise "Error, there is no \"#{name}\" #{type}" if hash[name].nil?
    hash[name]
  end

  def nil_validation?(string)
    raise 'Hmm, input is empty.' if string.empty?
    true
  end
end

main = Main.new
main.interface
