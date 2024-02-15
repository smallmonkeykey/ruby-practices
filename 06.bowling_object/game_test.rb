# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'game'

class GameTest < Minitest::Test
  def calculate_score(user_input)
    marks = user_input.split(',')
    game = Game.new(marks)
    game.calculate_score
  end

  def test_perfect
    user_input = 'X,X,X,X,X,X,X,X,X,X,X,X'
    assert_equal 300, calculate_score(user_input)
  end

  def test_10th_frame_is_spare
    user_input = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5'
    assert_equal 139, calculate_score(user_input)
  end

  def test_normal
    user_input = '0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4'
    assert_equal 107, calculate_score(user_input)
  end
end
