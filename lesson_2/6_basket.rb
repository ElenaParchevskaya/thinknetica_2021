basket = {}

loop do
  puts "\nВведите наименование товара или 'stop'"
  title = gets.chomp
  break if title == 'stop'
  puts "Введите цену за единицу товара #{title}"
  price = gets.chomp.to_f
  puts "Введите количество товара #{title}"
  quantity = gets.chomp.to_f
  basket[title] = { price: price, quantity: quantity }
end

sum_titles = 0
basket.each do |title, price_quantity|
  print "#{title}, цена за 1 шт: #{price_quantity[:price]},  "
  print "количество: #{price_quantity[:quantity]}. "
  sum_title = price_quantity[:price] * price_quantity[:quantity]
  sum_titles += sum_title
  puts "Итого #{title}: #{sum_title}"
end

puts "\nОбщая сумма покупки: #{sum_titles}"
