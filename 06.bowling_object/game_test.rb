require 'minitest/autorun'
require_relative 'game'

class GameTest < Minitest::Test
  def calculate_total_score(result)
    game = Game.new(result)
    game.total_score
  end

  def test_game1
    result = 'X,X,X,X,X,X,X,X,X,X,X,X'
    assert_equal 300, calculate_total_score(result)
  end

  def test_game2
    result = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5'
    assert_equal 139, calculate_total_score(result)
  end

  def test_game3
    result = '0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4'
    assert_equal 107, calculate_total_score(result)
  end
end
