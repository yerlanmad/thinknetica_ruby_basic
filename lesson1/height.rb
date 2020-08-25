print 'Enter your name: '
name = gets.chomp

print 'Enter your height (in cm): '
height = gets.chomp

ideal_weight = (height.to_i - 110) * 1.15

if ideal_weight < 0
  puts 'Your weight is already optimal'
else
  puts "#{name}, your ideal weight is #{ideal_weight}"
end
