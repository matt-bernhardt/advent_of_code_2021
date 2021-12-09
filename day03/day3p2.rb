def load_and_parse(file)
  input = File.read(file).split("\n")
  puts "Found " + input.length.to_s + " lines in " + file.to_s

  # Split lines into arrays themselves
  rebuild = []
  input.each do |line|
    rebuild << line.split("").map(&:to_i)
  end
  puts "Processed lines:"
  pp rebuild
  rebuild
end

def plurality(array, bias)
  puts "Calculating plurality of " + array.to_s
  if (array.sum().to_f / array.size().to_f == 0.5)
    puts "Equality detected in " + array.to_s
    puts "Returning bias value of " + bias.to_s
    result = bias
  else
    puts "Plurality result: " + result.to_s
    if bias == 1
      result = (array.sum().to_f / array.size().to_f).round()
    else
      result = ((array.sum().to_f / array.size().to_f).round() - 1).abs()
    end
  end
  result
end

def row_to_dec(array)
  puts "Combining array to binary to decimal"
  array.join.to_i(2)
end

def calculate(array, bias)
  puts "Starting calculation, with bias of " + bias.to_s
  working = array
  i = 0
  while working.count > 1
    puts "=========="
    puts "Pass " + i.to_s
    puts "Data:"
    pp working
    puts "Needle:"
    needle = plurality(working.transpose[i], bias)
    pp needle 
    working = working.select { |row|
      row[i] == needle
    }
    i += 1
  end
  puts "---------------"
  puts "Outcome:"
  pp working
  row_to_dec(working[0])
end

def process(file)
  # Read file into array of lines
  data = load_and_parse(file)


  puts "-=-=-=-=-=-=-=-=-=-"
  puts "Calculating oxygen generator rating..."
  oxygen = calculate(data, 1)
  puts "Oxygen generator rating: " + oxygen.to_s

  puts "-=-=-=-=-=-=-=-=-=-"
  puts "Calculating CO2 scrubber rating..."
  co2 = calculate(data, 0)
  puts "CO2 scrubber rating: " + co2.to_s

  puts "Power consumption: " + (oxygen * co2).to_s

  puts "----- End of file -----\n\n"
end

process("sample.txt")
process("input1.txt")
