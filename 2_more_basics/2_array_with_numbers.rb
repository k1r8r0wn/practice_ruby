# 2. Заполнить массив числами от 10 до 100 с шагом 5.

array = (10..100).to_a

# Way 1
array.delete_if { |x| x % 5 != 0 }
p array

# Way 2
array.map! do |num|
  num = num % 5 == 0? num : nil
end
array.compact!
p array
