# 3. Прямоугольный треугольник.

# Программа запрашивает у пользователя 3 стороны треугольника и определяет,
# является ли треугольник прямоугольным, используя теорему Пифагора и выводит результат на экран.
# Также, если треугольник является при этом равнобедренным (т.е. у него равны любые 2 стороны),
# то дополнительно выводится информация о том, что треугольник является таковым.

# Подсказка: чтобы воспользоваться теоремой Пифагора, необходимо сначала найти самую длинную сторону (гипотенузу)
# и сравнить ее значение в квадрате с суммой квадратов двух остальных сторон.
# Если все 3 стороны равны, то треугольник равнобедренный и равносторонний, но не прямоугольный.

puts "Let's check the type of your triangle..."

puts 'Please, type the length of first side:'
first_side = gets.chomp.to_f

puts 'Now type the length of second side:'
second_side = gets.chomp.to_f

puts 'And finally the third one:'
third_side = gets.chomp.to_f

if first_side == second_side && first_side == third_side
  equilateral_triangle = true
else
  equilateral_triangle = false
  isosceles_triangle = first_side == second_side || second_side == third_side || first_side == third_side ? true : false
  sides = [first_side, second_side, third_side]
  hypotenuse = sides.max
  sides.delete_at(sides.index(hypotenuse))
  right_triangle = (hypotenuse**2).to_i == ( (sides[0]**2) + (sides[1]**2) ).to_i ? true : false
end

if equilateral_triangle
  puts "It's the equilateral triangle, because all it's sides have same length."
elsif isosceles_triangle && right_triangle
  puts 'You have the isosceles triangle & the right triangle at same time.'
elsif isosceles_triangle && !right_triangle
  puts "It's the isosceles triangle, because it has 2 sides with same length."
elsif !isosceles_triangle && right_triangle
  puts "With a help of Pythagorean theorem it's the right triangle."
else
  puts 'Sorry, do you think that this figure is a triangle?!'
end
