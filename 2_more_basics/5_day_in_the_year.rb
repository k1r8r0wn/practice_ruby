# 5. Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя).
# Найти порядковый номер даты, начиная отсчет с начала года.
# Учесть, что год может быть високосным.

common_year_days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

puts "Hello, this is a program that tells you what is the current number of a day is today, counting from the beginning of a year."
puts "All you need is to type today's date in format: DD/MM/YYYY:"

puts "Please, enter today's day number: (for example: 7 or 07):"
day = gets.chomp.to_i

puts "Great, now type month (for example: 5 or 05 for 'may'):"
month = gets.chomp.to_i

puts "And the last thing is a year (for example: 2016):"
year = gets.chomp.to_i

if ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0))
  leap_year = true
else
  leap_year = false
end

leap_year ? common_year_days_in_month[1] = 29 : nil

day_of_the_year = common_year_days_in_month.first(month - 1).inject(day){ |days, month| days + month }

puts "Today is a: #{day_of_the_year}'s day of the year."
