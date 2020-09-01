print 'Enter day: '
day = gets.chomp.to_i
print 'Enter month: '
month = gets.chomp.to_i
print 'Enter year: '
year = gets.chomp.to_i

months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

if year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)
  months[1] = 29
end

ordinal_day = day
months.each.with_index(2) { |mm, index| ordinal_day += mm unless month < index }

puts ordinal_day
