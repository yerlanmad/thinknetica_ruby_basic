print 'Enter a: '
a = gets.chomp.to_f

print 'Enter b: '
b = gets.chomp.to_f

print 'Enter c: '
c = gets.chomp.to_f

d = b ** 2 - 4 * a * c

if a == 0
  puts 'The equation is linear'
elsif d >= 0
  x1 = (-b + Math.sqrt(d)) / 2 * a
  x2 = (-b - Math.sqrt(d)) / 2 * a
  puts "D = #{d}, x1 = #{x1}, x2 = #{x2}"
else
  puts "D = #{d}, there is no roots"
end
