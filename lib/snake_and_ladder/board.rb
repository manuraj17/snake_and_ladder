class Board
  attr_accessor :@cells, :@total_cells

  def initialize
    # Read the json file and parse it
    config = JSON.parse(File.read("#{Dir.pwd}/config.json"))

    # Settings are to be placed in config.json
    @total_cells = config['cells']
    @cells = []

    # Initialising all the snakes
    config['snakes'].each do |s|
      if s['head'] < ['tail']
        abort 'Error, snake head position must be greater than tail'
      end
      # Checking if positions are valid for the board
      if !s['head'].between?(0,@total_cells) || !s['tail'].between?(0, @total_cells)
        abort 'Erro, invalid position'
      end

      snake = Cell.new('snake', s['head'], s['tail'])
      @cells[s['cell']] = snake
    end

    # Initialising all the ladders
    config['ladders'].each do |l|
      # Checking if positions are valid for the board
      if !l['start'].between?(0, @total_cells) || !l['end'].between?(0, @total_cells)
        abort 'Erro, invalid position'
      end
      ladder = Cell.new('ladder', l['start'], l['end'])
      @cells[l['cell']] = ladder
    end
  end

  def check(position)
    if @cells[position].snake?
      return 'snake', @cells[position].start, @cells[position].end
    elsif
      return 'ladder', @cells[position].start, @cells[position].end
    end
  end
end
