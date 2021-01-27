def side (name)
  puts "Введите сторону #{name}"
  gets.chomp.to_f
end

a = side('a')
b = side('b')
c = side('c')

s_max = [a, b, c].max
s_min1, s_min2 =  [a, b, c].min(2)

if a == b && b == c
  puts 'Тругольник равносторонний и равнобедренный'
elsif b == c || a == c || b == a
  puts 'Треугольник равнобедренный'
elsif s_max**2 == s_min1**2 + s_min2**2
  puts 'Треугольник прямоугольный'
else
  puts 'обычный треугольник'
end
