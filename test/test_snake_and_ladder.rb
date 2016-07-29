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


  def test_invalid_config
    c = Cell.new
    assert_raise ArgumentError do
      c.set_entity('snake', '5', '5')
      c.set_entity('ladder', '5','5')
    end
  end

  def test_valid_config
    c1 = Cell.new
    c2 = Cell.new
    assert_nothing_raise ArgumentError do
      c1.set_entity('snake', '5', '5')
      c2.set_entity('ladder', '5','5')
    end
  end

end
