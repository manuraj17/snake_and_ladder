# The 'Game' class. Most of the action happens. It is wrapped around the classes
# 'Player' and 'Board'. This class controls the flow of the game and has the
# 'play' method which is where the game is actually being played.
class Game
  attr_accessor :no_of_players
  def initialize(no_of_players)
    @no_of_players = no_of_players
    @board = Board.new
  end

  # Initialising each player for the game
  def init_players
    @players = []
    (1..no_of_players).each do |i|
      puts "Enter name for the player #{i}. only characters and numbers allowed"
      name = gets.chomp
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
        # Skip the player if he has already won
        if p.won
          next
        end
        # Rolling the dice
        # Use the below function to simulate the game
        # dice_roll = 1+rand(6)
        # Fetching the dice rolled
        puts "#{p.name}, please enter dice roll"
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
          players -= 1
          next
        end
        # Checking if the position has any entity
        entity, start_position, end_position = @board.check(p.position)
        if entity.nil?
          next
        elsif entity.eql?('snake')
          puts "#{p.name} has encountered a snake at position"\
                "#{start_position}, will now move to #{end_position}"
        else
          puts "#{p.name} has reached a ladder at position"\
                "#{start_position}, will now move to #{end_position}"
        end

        # Placing the player at the target end position
        p.position = end_position.to_i
        if p.position >= @board.total_cells
          puts "#{p.name} has completed the game"
          p.won = true
          players -= 1
          #next
        end
      end
      break if players.eql?(0)
    end
  end
end
