# The 'Game' class. Most of the action happens. It is wrapped around the classes
# 'Player' and 'Board'. This class controls the flow of the game and has the
# 'play' method which is where the game is actually being played.
class Game
  attr_accessor :no_of_players, :board
  def initialize(no_of_players)
    if no_of_players <= 1
      raise 'Should atleast have 2 players to play'
    end
    @no_of_players = no_of_players
  end

  def init_board
    @board = Board.new
    @board.setup
  end

  # To check if a player name already exists
  def check_player_name_exists(name)
    return false if @players.nil?
    @players.each do |p|
      return true if p.name.eql?(name)
    end
    false
  end

  # Initialising each player for the game
  def init_players
    @players = []
    puts "Enter player names, only characters and numbers are allowed with length between 3 and 9."
    (1..no_of_players).each do |i|
      puts "Name for Player #{i}: "
      name = gets.chomp
      if check_player_name_exists(name)
        puts "Player name exists, please try another"
        redo
      end
      p = Player.new(i, name)
      @players.push(p)
    end
  end

  # The main driver function for the game
  def play
    puts "Total number of players - #{@no_of_players}"
    puts "Beginning game"
    players = @no_of_players
    # The infinite loop for the game
    while true do
      # Turn by turn play for each player
      @players.each do |p|
        # Rolling the dice
        # Use the below line to simulate the game
        # dice_roll = 1+rand(6)
        # Fetching the dice rolled
        puts "#{p.name}, please enter the dice roll"
        dice_roll = gets.chomp.to_i
        while !dice_roll.between?(1,6)
          puts "Please enter a valid dice roll"
          dice_roll = gets.chomp.to_i
        end
        puts "#{p.name} has rolled the dice and got #{dice_roll}"

        # Incrementing player position
        p.position = p.position + dice_roll
        puts "#{p.name} has moved to #{p.position}"

        # Checking if player won
        if p.position >= @board.total_cells
          puts "#{p.name} has completed the game"
          p.won = true
          puts "Game over!"
          exit
        end

        entity, start_position, end_position = @board.check(p.position)
        # Checking if the position has any entity
        if entity.eql?('snake')
          puts "#{p.name} has encountered a snake at position"\
                " #{start_position}, will now move to #{end_position}"
        elsif entity.eql?('ladder')
          puts "#{p.name} has reached a ladder at position"\
                " #{start_position}, will now move to #{end_position}"
        end

        # Placing the player at the target end position
        p.position = end_position.to_i unless end_position.nil?
        if p.position >= @board.total_cells
          puts "#{p.name} has completed the game"
          p.won = true
          puts "Game over!"
          exit
        end

        if dice_roll.eql?(6);
          puts "#{p.name} has rolled a 6, he will get another chance to roll"
          redo
        end
      end
    end
  end
end
