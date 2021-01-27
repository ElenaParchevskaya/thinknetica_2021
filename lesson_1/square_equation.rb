def side (coefficient)
  puts "Введите коэффициент #{coefficient}"
  gets.chomp.to_f
end

a = side('a')
b = side('b')
c = side('c')

d = (b**2) - (4 * a * c)

if d > 0
  d_s = Math.sqrt(d)
  # Два корня.
  x_1 = ((- b + d_s) / (2 * a)).round(1)
  x_2 = ((- b - d_s) / (2 * a)).round(1)
  puts "D=#{d}"
  puts "Корни уравнения X1 = (#{x_1}) and X2 = (#{x_2})"
elsif d == 0
  x = ((- b) / (2 * a)).round(1)
  puts 'Дикриминант D = 0'
  puts "Корни уравнения X1 = X2 = (#{x_1_2})"
else
  puts "Дикриминант D = (#{d}), корней нет"
end
