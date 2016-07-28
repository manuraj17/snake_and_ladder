class Player
  attr_reader :id, :name

  def initialize(id, name)
    @id = id
    @name = name
    @position = 0
    @won = false
  end
  # Player will have the id as player 1 etc
  # Player will have the current position
  # Player will have the status won or not

  # Initial position of every player is 0/1
end
