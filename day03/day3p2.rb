def load_and_parse(file)
  input = File.read(file).split("\n")
  puts "Found " + input.length.to_s + " lines in " + file.to_s

  # Split lines into arrays themselves
  rebuild = []
  input.each do |line|
    rebuild << line.split("").map(&:to_i)
  end

  rebuild
end

def plurality(array, bias)
  return bias if array.sum().to_f / array.size().to_f == 0.5
  if bias == 1
    result = (array.sum().to_f / array.size().to_f).round()
  else
    result = ((array.sum().to_f / array.size().to_f).round() - 1).abs()
  end
  result
end

def row_to_dec(array)
  array.join.to_i(2)
end

def calculate(array, bias)
  working = array
  i = 0
  while working.count > 1
    needle = plurality(working.transpose[i], bias)
    working = working.select { |row|
      row[i] == needle
    }
    i += 1
  end
  row_to_dec(working[0])
end

def process(file)
  # Read file into array of lines
  data = load_and_parse(file)

  oxygen = calculate(data, 1)
  puts "Oxygen generator rating: " + oxygen.to_s

  co2 = calculate(data, 0)
  puts "CO2 scrubber rating: " + co2.to_s

  puts "Power consumption: " + (oxygen * co2).to_s

  puts "----- End of file -----\n\n"
end

process("sample.txt")
process("input1.txt")
