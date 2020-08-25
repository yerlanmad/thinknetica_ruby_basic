print "Enter trinangle's first side: "
side1 = gets.chomp

print "Enter trinangle's second side: "
side2 = gets.chomp

print "Enter trinangle's third side: "
side3 = gets.chomp

sides = [side1.to_i, side2.to_i, side3.to_i].sort
is_right = sides[2] ** 2 == (sides[0] ** 2 + sides[1] ** 2)

if sides[0] == sides[1] && sides[0] == sides[2]
  puts 'It is isosceles and equilateral triangle'
elsif sides[0] == sides[1] && is_right
  puts 'It is isosceles and right triangle'
elsif sides[0] == sides[1]
  puts 'It is isosceles triangle'
elsif is_right
  puts 'It is right triangle'
else
  puts 'It is ordinary triangle'
end
