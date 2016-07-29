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
      if File.file?("#{Dir.pwd}/config.json")
        puts "Using user provided board config"
        @config = JSON.parse(File.read("#{Dir.pwd}/config.json"))
          else
        puts "No board config file found, please enter board details to start game"
        # @config = JSON.parse(File.read(File.expand_path("../../config.json", __FILE__)))
        @config = []
      end
    rescue Exception => e
      raise "Error, file not found!: #{e}"
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
    unless @cells[start_position.to_i].nil?
      raise ArgumentError.new 'An entity already exists in this position'
    end
    if !start_position.to_i.between?(0, @total_cells) || !end_position.to_i.between?(0, @total_cells)
      raise ArgumentError.new 'Error, invalid position'
    end
    e = Cell.new
    if entity.eql?('snake')
      e.snake = true

      if start_position.to_i <= end_position.to_i
        raise ArgumentError.new 'Error, snake head position must be greater than tail'
      end

      # Checking if positions are valid for the board

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
      return nil, nil, nil
    elsif @cells[position].snake
      return 'snake', @cells[position].start, @cells[position].end
    elsif @cells[position].ladder
      return 'ladder', @cells[position].start, @cells[position].end
    end
  end
end
