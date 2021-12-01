input = File.read("input1.txt").split.map{|v| v.to_i}.to_a

puts input.length.to_s + " measurements"
puts "First measurement, " + input[0].to_s + ", is a " + input[0].class.to_s

deeper = 0

for i in 0...input.length - 2
  next if i+3 > input.length
  first = input[i..i+2]
  second = input[i+1..i+3]
  deeper += 1 if first.sum < second.sum
end

puts deeper.to_s + " steps deeper"
