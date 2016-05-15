# 4. Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).

alphabet = ('a'..'z')
vowels = {}

alphabet.each_with_index do |letter, index|
  vowels[letter.to_sym] = index if %w(a e o u i y).include?(letter)
end

p vowels
