def plurality(array)
  (array.sum().to_f / array.size().to_f).round()
end

def process(file)
  # Read file into array of lines
  input = File.read(file).split("\n")
  puts "Found " + input.length.to_s + " lines in " + file.to_s

  # Split lines into arrays themselves
  rebuild = []
  input.each do |line|
    rebuild << line.split("").map(&:to_i)
  end
  # pp rebuild

  # rebuild is now an array of arrays

  xpose = rebuild.transpose
  gamma = []
  epsilon = []
  xpose.each do |column|
    # pp column
    gamma << plurality(column)
    epsilon << (plurality(column) - 1).abs()
  end

  puts "Gamma:"
  # pp gamma
  gamma = gamma.join.to_i(2)
  puts gamma

  puts "Epsilon:"
  # pp epsilon
  epsilon = epsilon.join.to_i(2)
  puts epsilon

  puts "Power consumption: " + (gamma * epsilon).to_s

  puts "----- End of file -----\n\n"
end

process("sample.txt")
process("input1.txt")
