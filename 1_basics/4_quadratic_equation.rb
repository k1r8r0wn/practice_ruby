# 4. Квадратное уравнение.

# Пользователь вводит 3 коэффициента a, b и с.
# Программа вычисляет дискриминант (D) и корни уравнения (x1 и x2, если они есть)
# и выводит значения дискриминанта и корней на экран.

# При этом возможны следующие варианты:

# Если D > 0, то выводим дискриминант и 2 корня
# Если D = 0, то выводим дискриминант и 1 корень (т.к. они в этом случае равны)
# Если D < 0, то выводим дискриминант и сообщение "Корней нет"

# Подсказки: Для вычисления квадратного корня, нужно использовать `Math.sqrt`,
# например, `Math.sqrt(16)` вернет 4, т.е. квадратный корень из 16.

puts "We are going to solve quadratic equation (ax² + bx + c = 0)"

puts "Please, enter value 'a':"
a = gets.chomp.to_f

puts "Now, enter value 'b':"
b = gets.chomp.to_f

puts "And the last one - value 'c':"
c = gets.chomp.to_f

D = b**2 - 4 * a * c

if D > 0
  x1 = (-b - Math.sqrt(D)) / (2 * a)
  x2 = (-b + Math.sqrt(D)) / (2 * a)
  puts "The answer is: x1 = #{x1}, x2 = #{x2}, discriminant is equal: #{D}."
elsif D == 0
  x = -b / 2 * a
  puts "The anser is x = #{x}, discriminant is equal: #{D}."
else
  puts "There is no solution for this quadratic equation because discriminant < 0."
end
