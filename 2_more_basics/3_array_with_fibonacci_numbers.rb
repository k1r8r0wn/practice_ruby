# 3. Заполнить массив числами фибоначи до 100.

fib = [0]
fib_number = 1

while fib_number < 100
  fib << fib_number
  fib_number = fib[fib.size - 1] + fib[fib.size - 2]
end

p fib
