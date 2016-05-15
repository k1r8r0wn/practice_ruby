# Идеальный вес.
# Программа запрашивает имя и рост и выводит идеальный вес по формуле
# <рост> - 110, после чего выводит результат пользователю на экран с обращением по имени.
# Если идеальный вес получается отрицательным, то выводится строка "Ваш вес уже оптимальный".

puts 'What is your name?'

name = gets.chomp.capitalize

puts 'Enter your height in centimeters, please:'

height = gets.chomp.to_i

MAGIC_NUMBER = 110

ideal_weight = height - MAGIC_NUMBER

if ideal_weight == 0 || ideal_weight < 0
  puts 'You already have an ideal weight. Congratulations!'
else
  puts "#{name}, your ideal weight is: #{ideal_weight} kilograms."
end
