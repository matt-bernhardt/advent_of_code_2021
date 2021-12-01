input = File.read("input1.txt").split

last = "start"
deeper = 0
count = 0

input.each do |line|
  count += 1
  if last != "start" && line.to_i > last.to_i
    deeper += 1
    message = "increase"
  end
  puts count.to_s + ": (" + deeper.to_s + ") " + line.to_s + " " + message.to_s
  last = line
end

puts deeper.to_s + " steps deeper"
