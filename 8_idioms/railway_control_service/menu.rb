class Menu
  COMMANDS = {
    s: 'menu_create_station',
    pt: 'menu_create_passenger_train',
    ct: 'menu_create_cargo_train',
    h: 'menu_hook_carriage',
    un: 'menu_unhook_carriage',
    a: 'menu_allow_arrival',
    i: 'menu_information'
  }

  def start!
    main_menu
    command = choose_command
    throw :exit if command == :q
    command = COMMANDS[command] || 'menu_error'
    command.to_sym
  end

  def main_menu
    system('clear')
    puts Text.intro_message(:main_menu)
  end

  def choose_command
    puts Text.message(:type, :command)
    gets.chomp.downcase.to_sym
  end
end
