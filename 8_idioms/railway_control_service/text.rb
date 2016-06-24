module Text
  def self.message(arg, arg2)
    @message[arg][arg2]
  end

  def self.menu(arg)
    @message[:menu][arg]
  end

  def self.intro_message(arg)
    @message[arg][:intro]
  end

  def self.system(arg)
    @message[:system][arg]
  end

  @message = {
    main_menu: {
    intro: 'Welcome to Railway Control Service. Main commands:
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
    },
      menu_create_station: {
        intro: "You are going to create a station. Please, type station's name:"
    },

      menu_allow_arrival: {
        intro: 'You are going to allow train arrive on a platform to one of available stations:'
    },

      menu_create_cargo_train: {
        intro: 'You are going to create a cargo train. Please, type a number of the new cargo train:'

      },

      menu_create_passenger_train: {
        intro: 'You are going to create a passenger train. Please, type a number of the new passenger train:'
    },

      menu_unhook_carriage: {
        intro: "You are going to unhook a carriage from your train. \nTrains that are available to do this action, enter a train's number:"
    },

      menu_hook_carriage: {
        intro: "You are going to hook an extra carriage to your train. \nTrains that are available to do this action, enter a train's number:"
    },

      menu_information: {
        intro: 'Information about trains and stations:'
      },

      menu_error: {
        intro: "It's wrong command, please choose from the list."
    },

      type: {
        train: 'Ok, type train number:',
        command: 'Please, type a command to continue...'
    },

      system: {
        result: 'Done! You can check the result in information.',
        wrong: 'Wrong command',
        trains_not_ready: 'No ready trains now!',
        pause: "Press 'Enter' key to continue..."
    },

      train: {
        error_unhook: "Error, the train is moving or don't have carriage to unhook.",
        error_attach: 'Error, the train is moving. Stop it to do this operation.',
        error_move: "Error, the train can't move. You haven't got a permission to move or you're on final station of the route. You need to get allow to departure in the station first, or get new route.",
        route_last: 'The destination station in a route of the train is: ',
        route_first: 'The departure station in a route of the train is: ',
        info: %w(number type length speed)
    },

      station: {
        info: %w(Name Trains\ in\ the\ station: Cargo Passenger)
    },

      menu: {
        no_train: 'No trains',
        list_trains: 'List of trains:',
        no_station: 'No stations',
        list_stations: 'List of stations:',
        unhook: 'Train(-s) on station with carriage(-s) and zero speed:',
        hook: 'Train(-s) on station with zero speed:'
    }
  }
end
