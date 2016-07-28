class Game
  attr_accessor :@no_of_players
  def initialize(no_of_players)
    @no_of_players = no_of_players
    # Initialising each player for the game
    @players = []
    (1..@no_of_players).each do |i|
      puts "Enter name for the player #{i}"
      name = gets.chomp
      p = Player.new(i, name)
      @players.push(p)
    end
    # Initialising the board
    @board = Board.new
  end
    # Three standard to be considered 8x8, 10x10, or 12x12
    # As of now, the board will be 10x10
    # @board_size = board_size
    # Get the number of snakes
    # no_of_snakes = range(0, no_of_cells)
    # Initialise the start and end of each snake
    # start = range(1, no_of_cells)
    # end = range(0, no_of_cells - 1)
    # start > end
    # Get the number of ladders
    # no_of_ladders = range(0, no_of_cells)
    # Initialist each ladder
    # start = (1, no_of_cells)
    # Get the number of
  def play
    puts "Total number of players - #{@no_of_players}"
    puts "Beginning game"
    while true do
      @players.each do |p|
        if p.won?
          next
        end
        # Rolling the dice
        dice_roll = 1+rand(6)
        puts "Player #{p.id} has rolled the dice and got #{dice_roll}"
        # Incrementing player position
        p.position += dice_roll
        # Checking if the position has any entity
        entity, start_position, end_position = @board.check(p.position)
        if !entity.nil?
          p.position = end_position
        end
      end
    end
  end
end
