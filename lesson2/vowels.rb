vowels = ["a", "e", "i", "o", "u"]
hash = {}

("a".."z").each.with_index(1) do |letter, index| 
  hash[letter] = index if vowels.include?(letter) 
end
