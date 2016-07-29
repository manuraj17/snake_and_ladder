require 'json'
require_relative 'cell'
# The 'Board' class, this handles the initialisation of the board from config
# file.
class Board
  attr_accessor :cells, :total_cells

  def initialize
    # Settings are to be placed in config.json
    # Read the json file and parse it
    #puts "#{Dir.pwd}/config.json"
    begin
      if File.file?("#{Dir.pwd}/config.json")
        puts "Using user provided board config"
        @config = JSON.parse(File.read("#{Dir.pwd}/config.json"))
      else
        puts "No board config provided by user, using default"
        @config = JSON.parse(File.read(File.expand_path("../../config.json", __FILE__)))
      end
    rescue Exception => e
      raise "Error, file not found!: #{e}"
    end

    @total_cells = @config['total_cells'].to_i
    @cells = []
  end

  def set_entity(entity, start_position, end_position)
    unless @cells[start_position.to_i].nil?
      raise ArgumentError.new 'An entity already exists in this position'
    end
    e = Cell.new
    if entity.eql?('snake')
      e.snake = true
      #@cells[start_position].snake = true
    elsif entity.eql?('ladder')
      # A snake cell cannot be a ladder cell
      #if @cells[start_position].snake
      #                             "#{start_position}")
      #    raise ArgumentError.new("Config Error, block alread set for snake"\
      #end
      #@cells[start_position].ladder = true
      e.ladder = true
    end
    e.start = start_position
    e.end = end_position
    @cells[start_position.to_i] = e
    #@cells[start_position].start = start_position
    #@cells[start_position].end = end_position
  end

  def set_snake(head, tail)
    #snake = Cell.new
    #snake.set_entity('snake', s['head'], s['tail'])
    #if !@cell[head.to_i].nil?
    #  raise ArgumentError.new 'An entity already exists in this position'
    #end
    #@cells[head.to_i] = snake
  end

  def initialise_entities
    # Initialising all the snakes
    @config['snakes'].each do |s|
      if s['head'].to_i < s['tail'].to_i
        abort 'Error, snake head position must be greater than tail'
      end
      # Checking if positions are valid for the board
      if !s['head'].to_i.between?(0, @total_cells) || !s['tail'].to_i.between?(0, @total_cells)
        abort 'Erro, invalid position'
      end

      #snake = Cell.new
      set_entity('snake',s['head'], s['tail'])

      #snake.set_entity('snake', s['head'], s['tail'])
      #@cells[s['head'].to_i] = snake
    end

    # Initialising all the ladders
    @config['ladders'].each do |l|
      # Checking if positions are valid for the board
      if !l['start'].to_i.between?(0, @total_cells) || !l['end'].to_i.between?(0, @total_cells)
        abort 'Error, invalid position'
      end
      set_entity('ladder',l['start'], l['end'])
      # ladder = Cell.new
      # ladder.set_entity('ladder', l['start'], l['end'])
      # if !@cells[l['start'].to_i].nil?
      #   raise ArgumentError.new "Error, wrong config"
      # end
      # @cells[l['start'].to_i] = ladder
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
