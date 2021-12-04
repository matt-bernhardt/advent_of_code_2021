# This prints the current position of the sub
def current_state(state)
	puts "Current position:"
	puts "X: " + state["x"].to_s
	puts "Y: " + state["y"].to_s
	puts "Aim: " + state["aim"].to_s
	puts "Product: " + (state["x"] * state["y"]).to_s
end

# This takes an array of arrays (a set of commands) and updates 
def follow_commands(steps)
	state = {}
	state["x"] = 0
	state["y"] = 0
	state["aim"] = 0

	steps.each do |step|
		if step[0] == "forward"
			state["x"] += step[1]
			state["y"] += state["aim"] * step[1]
		elsif step[0] == "down"
			state["aim"] += step[1]
		elsif step[0] == "up"
			state["aim"] -= step[1]
		else
			puts "ERROR!!!!"
		end
	end

	current_state(state)
end

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

	follow_commands(commands)
end

process("sample.txt")
process("input1.txt")
