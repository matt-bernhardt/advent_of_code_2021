
# This splits an array of lines into commands
def parse_input(lines)
	rebuild = []
	lines.each do |line|
		temp = line.split(" ")
		rebuild.push([temp[0], temp[1].to_i])
	end
	rebuild
end

def process(file)
	input = File.read(file).split("\n")
	puts "Found " + input.length.to_s + " lines"
	commands = parse_input(input)

	x = 0
	y = 0
	commands.each do |step|
		if step[0] == "forward"
			x += step[1]
		elsif step[0] == "down"
			y += step[1]
		elsif step[0] == "up"
			y -= step[1]
		else
			puts "ERROR!!!!"
		end
	end

	puts "Current position:"
	puts "X: " + x.to_s
	puts "Y: " + y.to_s
	puts "Product: " + (x*y).to_s
end

process("sample.txt")
process("input1.txt")
