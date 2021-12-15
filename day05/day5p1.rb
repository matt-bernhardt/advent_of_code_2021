class Map
  def initialize
    @debug = false
    @map = []
    @maxX = 0
    @maxY = 0
    @part = 2
    @vents = []
    if @part == 2
      puts "Solving part 2"
    else
      puts "Solving part 1"
    end
  end

  def count_vents
    puts "\n----------"
    puts "Counting vents on map..."
    result = 0
    @map.each do |line|
      line.each do |point|
        result += 1 if point > 1
      end
    end
    puts result.to_s + " vents detected"
  end

  def load_and_parse(file)
    input = File.read(file).split("\n")
    puts input.length.to_s + " lines in file"

    input.each do |line|
      vent = []
      temp = line.split(" -> ").each do |coords|
        spot = coords.split(",").map(&:to_i)
        @maxX = spot[0] if spot[0] > @maxX
        @maxY = spot[1] if spot[1] > @maxY
        vent << spot
      end
      @vents << vent
    end

    log "List of vents"
    @vents.each do |vent|
      log vent
    end
    log "Maximum X: " + @maxX.to_s
    log "Maximum Y: " + @maxY.to_s

    populate_map

    draw

  end

  private

  def draw
    puts "- Map -----"
    @map.transpose.each do |row|
      line = ""
      row.each do |point|
        if point > 0
          line += point.to_s + " "
        else
          line += ". "
        end
      end
      puts line
    end
  end

  def log(message)
    puts message.to_s if @debug
  end

  def populate_map
    log "Creating map"
    @map = Array.new(@maxX+1){Array.new(@maxY+1, 0)}
    @vents.each do |vent|
      log "\n------------"
      log "Adding vent from " + vent[0][0].to_s + "," + vent[0][1].to_s + " to " + vent[1][0].to_s + "," + vent[1][1].to_s
      if vent[0][0] != vent[1][0] && vent[0][1] == vent[1][1]
        log "only X digit changes"
        populate_x(vent[0][0], vent[1][0], vent[0][1])
      elsif vent[0][0] == vent[1][0] && vent[0][1] != vent[1][1]
        log "only Y digit changes"
        populate_y(vent[0][1], vent[1][1], vent[0][0])
      else
        log "diagonal line"
        populate_diag(vent[0][0], vent[0][1], vent[1][0], vent[1][1]) if @part == 2
      end
      draw if @debug
    end
  end

  def populate_x(x1, x2, y)
    for x in [x1,x2].min..[x1,x2].max
      @map[x][y] += 1
    end
  end

  def populate_y(y1, y2, x)
    for y in [y1,y2].min..[y1,y2].max
      @map[x][y] += 1
    end
  end

  def populate_diag(x, y, x2, y2)
    log "Populating diagonal vent from " + x.to_s + "," + y.to_s + " to " + x2.to_s + "," + y2.to_s
    stepX = x < x2 ? 1 : -1
    stepY = y < y2 ? 1 : -1
    until x == x2 do
      @map[x][y] += 1
      x += stepX
      y += stepY
    end
    @map[x2][y2] += 1
  end
end

map1 = Map.new
map1.load_and_parse("sample.txt")
map1.count_vents

map2 = Map.new
map2.load_and_parse("input1.txt")
map2.count_vents
