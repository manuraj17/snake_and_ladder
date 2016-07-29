# The 'Cell' class. This handles each cell block of the board, whether it is a
# ladder or a snake.
class Cell
  attr_accessor :snake, :ladder, :start, :end
  def initialize()
    @snake = false
    @ladder = false
    @start_position = 0
    @end_position = 0
    @cells = []
  end
  # Setting the cell block as snake or ladder
  def set_entity(entity, start_position, end_position)
    if !@cell[start_position].nil?
      raise ArgumentError.new 'An entity already exists in this cell'
    end
    if entity.eql?('snake')
      @snake = true
    elsif entity.eql?('ladder')
      # A snake cell cannot be a ladder cell
      if @snake
          raise ArgumentError.new("Config Error, block alread set for snake"\
                                   "#{start_position}")
      end
      @ladder = true
    end
    @start = start_position
    @end = end_position
  end
end
