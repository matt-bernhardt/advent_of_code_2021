class Bingo
  def initialize
    @cards = []
    @debug = false
    @draw = 0
    @draws = []
    @finished = []
  end

  def check(card, i)
    log "  Checking card " + i.to_s
    winner = false
    card.each do |line|
      winner = true if line.join() == "XXXXX"
    end
    card.transpose.each do |column|
      winner = true if column.join() == "XXXXX"
    end
    if winner == true
      @finished[i] = true
      summarize(card, i)
    end
  end

  def check_for_winner
    log "Checking for winner..."
    i = 0
    @cards.each do |card|
      if @finished[i] == false
        check(card, i)
      else
        log "  Card " + i.to_s + " already finished"
      end
      i += 1
    end
  end

  def load_and_parse(file)
    temp = File.read(file).split("\n\n")
    puts temp.length.to_s + " lines in file"

    @draws = temp[0].split(",").map(&:to_i)
    temp[1..].each do |card|
      @cards << parse_card(card)
      @finished << false
    end

    puts @draws.length.to_s + " numbers in draw sequence"
    puts @cards.length.to_s + " cards being played"
    status if @debug
  end

  def log(message)
    puts message.to_s if @debug
  end

  def parse_card(lines)
    card = []
    lines.split("\n").each do |line|
      card << line.split(" ").map(&:to_i)
    end
    card
  end

  def play
    log "Game begins..."
    d = 1
    @draws.each do |draw|
      log "\n===================="
      puts "Draw " + d.to_s + ": " + draw.to_s
      @draw = draw
      @cards.each do |card|
        update(card, draw)
      end
      check_for_winner
      status if @debug
      d += 1
    end
  end

  def render(card, i)
    puts "- Card " + i.to_s + " -----"
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
    puts "--------------"
  end

  def render_cards
    i = 0
    @cards.each do |card|
      render(card, i)
      i += 1
    end
  end

  def status
    puts "--- Current status ---"
    puts "Cards:"
    render_cards
    puts ""
    puts "Board status:"
    puts @finished.to_s
  end

  def summarize(card, i)
    puts "Summarizing card " + i.to_s + ":"
    render(card, "X")
    result = 0
    card.each do |line|
      line.each do |digit|
        if digit.class.to_s == "Integer"
          result += digit
        end
      end
    end
    puts "Board total: " + result.to_s
    puts "Board * Draw = " + (result * @draw).to_s
  end

  def update(card, number)
    card = card.each do |line|
      i = 0
      line.each do |digit|
        line[i] = "X" if line[i] == number
        i += 1
      end
    end
  end
end

game1 = Bingo.new
game1.load_and_parse("sample.txt")
game1.play

puts "\n\n\n\n"

game2 = Bingo.new
game2.load_and_parse("input1.txt")
game2.play
