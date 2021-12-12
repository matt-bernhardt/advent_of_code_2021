def check_cards(cards)
  cards.each do |card|
    result = check_for_winner(card)
    if result != false
      return result
    end
  end
  false
end

def check_for_winner(card)
  card.each do |line|
    return summarize_card(card) if line.join() == "XXXXX"
  end
  card.transpose.each do |column|
    return summarize_card(card) if column.join() == "XXXXX"
  end
  false
end

def load_and_parse(file)
  temp = File.read(file).split("\n\n")
  puts temp.length.to_s + " lines in file"

  input = {}
  input["draws"] = temp[0].split(",").map(&:to_i)

  input["cards"] = []
  temp[1..].each do |card|
    input["cards"] << parse_card(card)
  end

  input
end

def parse_card(lines)
  card = []
  lines.split("\n").each do |line|
    card << line.split(" ").map(&:to_i)
  end
  card
end

def play(cards, draws)
  puts "Game begins"
  winner = false
  until winner == true do
    d = 1
    draws.each do |draw|
      puts "\n===================="
      puts "Draw " + d.to_s + ": " + draw.to_s
      cards.each do |card|
        update_card(card, draw)
      end
      result = check_cards(cards)
      unless result == false
        puts "Winner on " + draw.to_s + "!"
        puts draw * result
        winner = true
        break
      end
      d += 1
    end
    break
  end
  if winner == true
    puts "The game has ended with a winner"
  else
    puts "The game ended with no winner"
  end
end

def render_card(card)
  card.each do |line|
    output = ""
    line.each do |number|
      if number.to_s.length == 2
        output += number.to_s + " "
      else
        output += " " + number.to_s + " "
      end
    end
    puts output
  end
end

def summarize_card(card)
  puts "Summarizing card"
  render_card(card)
  result = 0
  card.each do |line|
    line.each do |digit|
      if digit.class.to_s == "Integer"
        result += digit
      end
    end
  end
  puts result
  result
end

def update_card(card, number)
  card = card.each do |line|
    i = 0
    line.each do |digit|
      line[i] = "X" if line[i] == number
      i += 1
    end
  end
end

def process(file)
  # Load and parse input file into arrays of draws and cards
  input = load_and_parse(file)
  draws = input["draws"]
  cards = input["cards"]
  puts "Draws: " + draws.to_s
  puts cards.length.to_s + " cards:"
  cards.each do |card|
    pp card
  end

  # Play bingo
  play(cards, draws)
end

process("sample.txt")
process("input1.txt")
