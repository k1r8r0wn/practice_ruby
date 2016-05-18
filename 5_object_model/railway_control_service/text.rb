module Text

  def self.intro_message(arg)
    @message[arg][:intro]
  end

  def self.message(arg, arg2)
    @message[arg][arg2]
  end

  def self.system_message(arg)
    @message[:system][arg]
  end

  @message = {
    menu: {
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

    menu_create_cargo_train: {
      intro: 'You are going to create a cargo train. Please, type a number of the new cargo train:'
    },

    menu_create_passenger_train: {
      intro: 'You are going to create a passenger train. Please, type a number of the new passenger train:'
    },

    menu_hook_carriage: {
      intro: "You are going to hook an extra carriage to your train. \nTrains that are available to do this action, enter a train's number:"
    },

    menu_unhook_carriage: {
      intro: "You are going to unhook a carriage from your train. \nTrains that are available to do this action, enter a train's number:"
    },

    menu_allow_arrival: {
      intro: 'You are going to allow train arrive on a platform to one of available stations:'
    },

    menu_information: {
      intro: 'Information about trains and stations:'
    },

    menu_error: {
      intro: "It's wrong command, please choose from the list."
    },

    enter: {
      train: 'Ok, type train number:',
      command: 'Please, type a command to continue...'
    },

    system: {
      success: 'Done! You can check the result in information.',
      no_trains: 'No ready trains now!',
      pause: "Press 'Enter' key to continue..."
    },

    train: {
      unhook_error: "Error, the train is moving or don't have carriage to unhook.",
      hook_error: 'Error, the train is moving. Stop it to do this operation.',
      move_error: "Error, the train can't move. You haven't got a permission to move or you're on final station of the route. You need to get allow to departure in the station first, or get new route.",
      destination_station: 'The destination station in a route of the train is: ',
      departure_station: 'The departure station in a route of the train is: ',
      all_trains: 'number / type / length / speed'
    }
  }
end
