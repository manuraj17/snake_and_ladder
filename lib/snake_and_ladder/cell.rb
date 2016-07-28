class Cell
  attr_reader :@snake, :@ladder
  def initialize(entity, start_position, end_position)
    @snake = false
    @ladder = false
    if enity.eq?('snake')
      @snake = true
    elsif entity.eq?('ladder')
      if @snake
        abort 'Config error!' \
              "This block is already set for snake - #{start_position}"
      end
      @ladder = true
    end
    @start = start_position
    @end = end_position
  end
end
