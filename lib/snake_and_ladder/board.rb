require 'json'
require_relative 'cell'
# The 'Board' class, this handles the initialisation of the board from config
# file.
class Board
  attr_accessor :cells, :total_cells

  def initialize
    # Settings are to be placed in config.json
    # Read the json file and parse it
    begin
      @cells = []
      @total_cells = nil
      @config = []
      # Check if a config file is present in the current directory from which
      # the program is executed
      if File.file?("#{Dir.pwd}/config.json")
        puts "Config file found in current directory, use it? (y/n)"
        choice = gets.chomp.downcase
        # Parse the file if the user wants to use the detected config file
        if choice.downcase.eql?('y')
          @config = JSON.parse(File.read("#{Dir.pwd}/config.json"))
        end
      else
        puts "No board config file found, please enter board details to start game"
      end
    rescue Exception => e
      raise "Error #{e}"
    end
  end

  # Reading the configurations if no config file is provided
  def read_config
    puts "Enter total number of cells"
    total_cells = gets.chomp.to_i
    puts "Enter number of ladders"
    no_of_ladders = gets.chomp.to_i
    puts "Enter number of snakes"
    no_of_snakes = gets.chomp.to_i

    @total_cells = total_cells
    (1..no_of_snakes).each do |s|
      puts "Enter head position for snake #{s}"
      head = gets.chomp.to_i
      puts "Enter tail position for snake #{s}"
      tail = gets.chomp.to_i
      set_entity('snake', head, tail)
    end

    (1..no_of_ladders).each do |l|
      puts "Enter the start position of the ladder #{l}"
      start_position = gets.chomp.to_i
      puts "Enter the end position of the ladder #{l} "
      end_position = gets.chomp.to_i
      set_entity('ladder', start_position, end_position)
    end
  end

  # Setting the entity on specifc cells
  def set_entity(entity, start_position, end_position)
    # Raise an error if the position is already filled
    unless @cells[start_position.to_i].nil?
      raise ArgumentError.new 'An entity already exists in this position'
    end
    # Check if the positions are within range
    if !start_position.to_i.between?(0, @total_cells) || !end_position.to_i.between?(0, @total_cells)
      raise ArgumentError.new 'Error, invalid positions'
    end
    e = Cell.new
    if entity.eql?('snake')
      e.snake = true

      if start_position.to_i <= end_position.to_i
        raise ArgumentError.new 'Error, snake head position must be greater than tail'
      end

    elsif entity.eql?('ladder')
      e.ladder = true

      if start_position.to_i >= end_position.to_i
        raise ArgumentError.new "Invalid config, ladder start must be lesser than end"
      end

    end
    e.start = start_position
    e.end = end_position
    @cells[start_position.to_i] = e
  end

  # Initialising the game board
  def setup
    # If no config file was found
    if @config.empty?
      read_config
    else
      @total_cells = @config['total_cells'].to_i
      # Initialising all the snakes
      @config['snakes'].each do |s|
        set_entity('snake', s['head'], s['tail'])
      end
      # Initialising all the ladders
      @config['ladders'].each do |l|
        set_entity('ladder', l['start'], l['end'])
      end
    end
  end

  # Checking what the position holds, used during mid-game
  def check(position)
    if @cells[position].nil?
      # return nil if the cell holds no entity
      return 'empty', nil, nil
    elsif @cells[position].snake
      return 'snake', @cells[position].start, @cells[position].end
    elsif @cells[position].ladder
      return 'ladder', @cells[position].start, @cells[position].end
    end
  end
end
