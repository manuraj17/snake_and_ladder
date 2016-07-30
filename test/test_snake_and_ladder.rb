require_relative "../lib/snake_and_ladder/player"
require_relative "../lib/snake_and_ladder/board"
require_relative "../lib/snake_and_ladder/game"
require_relative "../lib/snake_and_ladder/cell"
require "test/unit"

class TestSnakeAndLadder < Test::Unit::TestCase

  def setup
    @game = Game.new(2)
  end

  def test_init
    assert_equal(2, @game.no_of_players)
  end

  def test_invalid_name #invalid case
    assert_raise ArgumentError do
      Player.new(0, "as:as")
    end

  end

  def test_valid_name
    assert_nothing_raised ArgumentError do
      Player.new(1, "Joe")
    end
  end


  def test_invalid_config_snake
    b = Board.new
    b.total_cells = 100
    assert_raise ArgumentError do
      b.set_entity('snake', '3', '5')
    end
  end

  def test_invalid_config_ladder
    b = Board.new
    b.total_cells = 100
    assert_raise ArgumentError do
      b.set_entity('ladder', '9', '2')
    end
  end

  def test_valid_config_snake
    b = Board.new
    b.total_cells = 100
    assert_nothing_raised ArgumentError do
      b.set_entity('snake', '30','10')
    end
  end

  def test_valid_config_ladder
    b = Board.new
    b.total_cells = 100
    assert_nothing_raised ArgumentError do
      b.set_entity('ladder', '5','10')
    end
  end

  def test_check_position
    b = Board.new
    b.total_cells = 100
    b.set_entity('snake', '30','10')
    assert_equal(['empty',nil,nil], b.check(10))
    assert_equal(['snake','30','10'], b.check(30))
  end
end
