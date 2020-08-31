cart = {}
loop do
  puts "Enter name of good or type 'stop' to exit"
  name = gets.chomp
  break if name.downcase == 'stop'

  puts "Enter price of #{name}"
  price =  gets.chomp.to_f
  puts "Enter quantity of #{name}"
  quantity = gets.chomp.to_f
  cart[name] = {
    'price' => price,
    'quantity' => quantity,
    'sum' => price * quantity
  }
end

total = 0
cart.each_key do |good|
  puts "#{good}:"
  puts "#{cart[good]['price']}$ x #{cart[good]['quantity']} = #{cart[good]['sum']}$"
  total += cart[good]['sum']
end
puts "Total: #{total}$"
