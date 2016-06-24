require_relative 'railway_control_service/text'

require_relative 'railway_control_service/data_center'

require_relative 'railway_control_service/check_error'

require_relative 'railway_control_service/menu'

require_relative 'railway_control_service/company'

require_relative 'railway_control_service/instance_counter'

require_relative 'railway_control_service/railway_station'

require_relative 'railway_control_service/route'

require_relative 'railway_control_service/train'
require_relative 'railway_control_service/passenger_train'
require_relative 'railway_control_service/cargo_train'

require_relative 'railway_control_service/carriage'
require_relative 'railway_control_service/cargo_carriage'
require_relative 'railway_control_service/passenger_carriage'

class Main
  attr_reader :data

  def initialize
    @data = DataCenter.new
    @check_error = CheckError.new
    @menu = Menu.new

    station = RailwayStation.new(:Berlin)
    RailwayStation.new(:Paris)

    passenger_train = PassengerTrain.new('Ppp-33'.to_sym)
    cargo_train = CargoTrain.new('Ccc-77'.to_sym)
    CargoTrain.new('Kkk-77'.to_sym)

    station.allow_arrival!(passenger_train)
    station.allow_arrival!(cargo_train)
  end

  def wrap_start!
    set_interface
  rescue StandardError => e
    puts e.message
    if @check_error.continue?
      puts 'You made an error, please try again.'
      pause
      retry
    else
      # puts e.backtrace
      raise 'Too much errors here! Bye, bye!'
    end
  end

  private

  def set_interface
    catch(:exit) do
      loop do
        command = @menu.start!
        throw :exit if command == :q
        menu_option(command)
      end
    end
  end

  def menu_option(option)
    puts Text.intro_message(option)
    send option
    puts Text.system(:result) if resulting_option?(option)
    pause
  end

  def menu_error; end

  def pause
    puts Text.system(:pause)
    gets
  end

  def request
    request = gets.chomp.capitalize.to_sym
    fail 'Error. Empty error!' if request.empty?
    request
  end

  def resulting_option?(option)
    resulting_option = %i(
      menu_create_station
      menu_create_passenger_train
      menu_create_cargo_train
      menu_hook_carriage
      menu_unhook_carriage
      menu_allow_arrival
    )
    resulting_option.include?(option)
  end

  def menu_create_station
    new_station_name = request
    data.initialize_station(new_station_name)
  end

  def menu_create_cargo_train
    new_train_number = request
    data.initialize_train(:cargo, new_train_number)
  end

  def menu_create_passenger_train
    new_train_number = request
    data.initialize_train(:passenger, new_train_number)
  end

  def menu_unhook_carriage
    puts "#{Text.menu(:unhook)} #{data.ready_to_unhook}"
    name = request
    data.unhook(name)
  end

  def menu_hook_carriage
    puts "#{Text.menu(:hook)} #{data.ready_to_hook}"
    name = request
    data.attach(name)
  end

  def menu_allow_arrival
    puts data.stations_list
    station_name = request
    puts "List of trains available to allow: #{data.trains_to_allow}"
    train_number = request
    data.allow_arrival(station_name, train_number)
  end

  def menu_information
    puts "#{data.trains_list_to_s}"
    puts "#{data.stations_list_to_s}"
  end
end

main = Main.new
main.wrap_start!
