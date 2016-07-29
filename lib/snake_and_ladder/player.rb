# The 'Player' class, this handles the initialization and holds each player
# for the game
class Player
  attr_accessor :id, :name, :won, :position

  def initialize(id, name)
    # Only alphanumeric names of length between 3 and 9 are allowed
    if /^([a-zA-Z0-9_]){3,9}$/.match(name).nil?
      raise ArgumentError.new("Invalid name")
    end
    @id = id
    @name = name
    @position = 1
    @won = false
  end
end
