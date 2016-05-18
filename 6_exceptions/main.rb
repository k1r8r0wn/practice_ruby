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

    cargo = CargoTrain.new(:cargo_13)
    moscow.allow_arrival! cargo
    PassengerTrain.new(:passenger_7)
  end

  def interface
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
  end

  private

  attr_reader :information

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
    name = gets.chomp.capitalize.to_sym
    RailwayStation.new(name)
  end

  def menu_create_cargo_train
    number = gets.chomp.to_sym
    CargoTrain.new(number)
  end

  def menu_create_passenger_train
    number = gets.chomp.to_sym
    PassengerTrain.new(number)
  end

  def menu_hook_carriage
    puts information.trains_available_to_hook_and_unhook_carriages
    if information.trains_available_to_hook_and_unhook_carriages == 'No trains are ready now!'
      puts 'You need to allow any train to any station first!'
    else
      puts 'Enter train number, please:'
      train = get_and_find(:train)
      train.hook_carriage
    end
  end

  def menu_unhook_carriage
    puts information.trains_available_to_hook_and_unhook_carriages
    if information.trains_available_to_hook_and_unhook_carriages == 'No trains are ready now!'
      puts 'You need to allow any train to any station first or your existing train(-s) have no carriages at all.'
    else
      puts 'Enter train number, please:'
      train = get_and_find(:train)
      train.unhook_carriage
    end
  end

  def menu_allow_arrival
    puts "#{information.stations}"
    puts 'Enter the station name, please:'
    station = get_and_find(:station)
    puts information.trains_available_to_allow
    puts 'Enter the train number, please:'
    train = get_and_find(:train)
    station.allow_arrival! train
    puts "Great! Now train №#{train.print_train_number} is at #{station.print_station_name} station."
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
    method = type == :train ? 'train' : 'station'
    hash = information.send method
    hash[name]
  end
end

main = Main.new
main.interface
