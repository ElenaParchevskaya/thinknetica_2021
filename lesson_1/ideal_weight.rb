print 'Ваше имя? '
name = gets.chomp

print 'Ваш рост? '
height = gets.chomp.to_i

if (optimal_weight = (height - 110) * 1.15) <= 0
  puts "#{name}, Ваш вес уже оптимальный"
else
  puts "#{name}, Ваш оптимальный вес #{optimal_weight}"
end
