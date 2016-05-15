# 6. Сумма покупок.

# Пользователь вводит поочередно название товара, цену за единицу и кол-во купленного товара
# (может быть нецелым числом). Пользователь может ввести произвольное кол-во товаров до тех пор,
# пока не введет "стоп" в качестве названия товара.
#
# На основе введенных данных требуетеся:
#
# Заполнить и вывести на экран хеш, ключами которого являются названия товаров,
# а значением - вложенный хеш, содержащий цену за единицу товара и кол-во купленного товара.
# Также вывести итоговую сумму за каждый товар.
# Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".

cart = {}
sum = 0
total_sum = 0

loop do
  puts "Please enter item's name you want to add to your card or 'stop' (without quotes) to exit the program:"
  name = gets.chomp
  break if name.downcase == 'stop'

  puts "Enter item's price:"
  price = gets.chomp.to_f

  puts "Enter item's amount:"
  amount = gets.chomp.to_f

  sum = price * amount
  cart[name]  = { price => amount }
  total_sum += sum

  puts "This items costs: #{sum}"
  puts "Here is what is in your cart: #{cart}"
  puts "Total sum of all items in the cart: #{total_sum}"
end
