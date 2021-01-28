puts 'введите число (1-31): '
day = gets.chomp.to_i

puts 'введите месяц (1-12): '
month = gets.chomp.to_i

puts 'введите год: '
year = gets.chomp.to_i

days_mounths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

day_count_month = days_mounths.take(month - 1).sum

leap_year = 29 if (year % 4).zero? && !(year % 100).zero? || (year % 400).zero?

day_count = day + day_count_month
day_count += 1 if leap_year && month > 2

puts "\n#{day}.#{month}.#{year} является #{day_count} в #{year} году!"
