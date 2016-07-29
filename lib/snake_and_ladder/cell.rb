# The 'Cell' class. This handles each cell block of the board, whether it is a
# ladder or a snake.
class Cell
  attr_reader :snake, :ladder, :start, :end
  def initialize()
    @snake = false
    @ladder = false
    @start_position = 0
    @end_position = 0
  end
  # Setting the cell block as snake or ladder
  def set_entity(entity, start_position, end_position)
    if entity.eql?('snake')
      puts "initing snake"
      @snake = true
      puts "#{@snake}"
    elsif entity.eql?('ladder')
      # A snake cell cannot be a ladder cell
      puts "Init ladder, snake val: #{@snake}"
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
