print 'Введите основание треугольника? '
base_of_triangle = Integer(gets.chomp)

print 'Введите высоту треугольника? '
height = Integer(gets.chomp)

area_triangle = base_of_triangle * height / 2

if area_triangle <= 0
  puts 'введены некоректные данные'
else
  puts "Площадь треугольника #{area_triangle}"
end
