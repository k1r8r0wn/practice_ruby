require_relative 'information'
require_relative 'railway_station'
require_relative 'train'
require_relative 'route'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'carriage'

class Main
  attr_reader :information

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
        system('clear')
        menu
        first_command = command
        throw :exit if first_command == 'q'
        case first_command
        when 's'
          menu_option(menu_create_station)
        when 'ct'
          menu_option(menu_create_cargo_train)
        when 'pt'
          menu_option(menu_create_passenger_train)
        when 'h'
          menu_option(menu_hook_carriage)
        when 'un'
          menu_option(menu_unhook_carriage)
        when 'a'
          menu_option(menu_allow_arrival)
        when 'i'
          menu_option(menu_information)
        else
          menu_option(error)
        end
      end
    end
  end

  private

  def menu
    greetings
    puts 'Main railway control commands:
    |-----------------------------------------------|
    |          s - create a new station             |
    |          ct - create a cargo train            |
    |         pt - create a passenger train         |
    |-----------------------------------------------|
    |        h - hook a carriage to the train       |
    |      un - unhook a carriage from the train    |
    |-----------------------------------------------|
    |     a - allow train to arrive on a station    |
    |-----------------------------------------------|
    |             i - show information              |
    |            q - quit control panel             |
    |-----------------------------------------------|'
  end

  def greetings
    puts 'Welcome to Railway Control Service.'
  end

  def menu_option(option)
    option
    pause
  end

  def command
    puts 'Please, type a command:'
    gets.chomp.downcase
  end

  def error
    puts "It's wrong command, please choose from the list."
  end

  def pause
    puts "Press 'Enter' key to continue..."
    gets
  end

  def menu_create_station
    puts "You are going to create a station. Please, type station's name:"
    name = gets.chomp.capitalize.to_sym
    RailwayStation.new(name)
    puts "Station '#{name.to_s}' successfully created!"
  end

  def menu_create_cargo_train
    puts 'You are going to create a cargo train. Please, type a number of the new cargo train:'
    number = gets.chomp.to_sym
    CargoTrain.new(number)
    puts "Cargo train №#{number} successfully created!"
  end

  def menu_create_passenger_train
    puts 'You are going to create a passenger train. Please, type a number of the new passenger train:'
    number = gets.chomp.to_sym
    PassengerTrain.new(number)
    puts "Passenger train №#{number} successfully created!"
  end

  def menu_hook_carriage
    puts 'You are going to hook an extra carriage to your train.'
    puts "Trains that are available to do this action: #{information.trains_available_to_hook_and_unhook_carriages}"
    if information.trains_available_to_hook_and_unhook_carriages == 'No trains are ready now!'
      puts 'You need to allow any train to any station first!'
    else
      puts 'Enter train number, please:'
      train = get_and_find_train
      train.hook_carriage
      puts 'Done! You can check the result in information.'
    end
  end

  def menu_unhook_carriage
    puts 'You are going to unhook a carriage from your train.'
    puts "Trains that are available to do this action: #{information.trains_available_to_hook_and_unhook_carriages}"
    if information.trains_available_to_hook_and_unhook_carriages == 'No trains are ready now!'
      puts 'You need to allow any train to any station first or your existing train(-s) have no carriages at all.'
    else
      puts 'Enter train number, please:'
      train = get_and_find_train
      train.unhook_carriage
      puts 'Done! You can check the result in information.'
    end
  end

  def menu_allow_arrival
    puts 'You are going to allow train arrive on a platform to one of available stations:'
    puts "#{information.stations}"
    puts 'Enter the station name, please:'
    station = get_and_find_station
    puts "Numbers of available trains to allow: #{information.trains_available_to_allow}"
    puts 'Enter the train number, please:'
    train = get_and_find_train
    station.allow_arrival! train
    puts "Great! Now train №#{train.print_train_number} is at #{station.print_station_name} station."
  end

  def menu_information
    if information[:train].empty? && information[:station].empty?
      puts '---------------------------'
      puts 'No stations & trains yet.'
      puts '---------------------------'
    elsif information[:station].empty?
      puts '------------------'
      puts 'No stations yet.'
      puts '-------------------------------'
      puts 'List of all available trains:'
      puts '-------------------------------'
      puts "#{information.trains_expanded}"
    elsif information[:train].empty?
      puts '---------------------------------'
      puts 'List of all available stations:'
      puts '---------------------------------'
      puts "#{information.stations}"
      puts '----------------'
      puts 'No trains yet.'
      puts '----------------'
    else
      puts '---------------------------------'
      puts 'List of all available stations:'
      puts '---------------------------------'
      puts "#{information.stations}"
      puts '-------------------------------'
      puts 'List of all available trains:'
      puts '-------------------------------'
      puts "#{information.trains_expanded}"
      puts '---------------------'
      puts 'Trains at stations:'
      puts '---------------------'
      puts "#{information.stations_expanded}"
      puts '-------------------------------'
    end
  end

  def get_and_find_train
    number = gets.chomp.to_sym
    information[:train].each.find { |train| train.number == number }
  end

  def get_and_find_station
    name = gets.chomp.to_sym
    information[:station].each.find { |station| station.name == name }
  end
end

main = Main.new
main.interface
