# 2. Площадь треугольника.
# Площадь треугольника можно вычиcлить, зная его основание (base) и высоту (height)
# по формуле: 1/2 * base * height.
# Программа должна запрашивать основание и высоту треуголиника и возвращать его площадь.

puts 'To find area of your triangle, we need to know lenght of the base, and height of the triangle, so..'
puts 'please, type the length of triangle base in centimetres:'

base = gets.chomp.to_i

puts 'And now the height of triangle in centimetres:'

height = gets.chomp.to_i

area = 1/2.to_f * base * height

if base == 0 || height == 0
  puts 'Triangle base or its height should not equal zero!'
else
  puts "Wuala, area of your triangle is: #{area.to_i} square centimetres."
end
