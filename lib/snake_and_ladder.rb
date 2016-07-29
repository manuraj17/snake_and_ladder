require_relative 'snake_and_ladder/version'
require_relative 'snake_and_ladder/game'
require_relative 'snake_and_ladder/player'
require_relative 'snake_and_ladder/board'

module SnakeAndLadder
  def self.start
    # Ask the number of players
    puts 'Welcome to Snakes and Ladders'
    puts ''
    puts 'Please enter then number of players'
    number_of_players = gets.chomp.to_i
    game = Game.new(number_of_players)
    game.init_players
    game.play
  end
end
