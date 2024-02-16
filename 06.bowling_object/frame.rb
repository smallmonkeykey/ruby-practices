# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_reader :first_shot, :second_shot

  STRIKE_SCORE = 10
	SPARE_SCORE = 10

  def initialize(first_mark, second_mark, third_mark = nil)
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
    @third_shot = Shot.new(third_mark)
  end

  def score_without_bonus
    score = first_shot.score + second_shot.score
    score += @third_shot.score if @third_shot.score != 0
    score
  end

  def spare?
    !strike? && first_shot.score + second_shot.score == SPARE_SCORE
  end

  def strike?
    first_shot.score == STRIKE_SCORE
  end

  def calculate_normal_frame(next_frame, after_next_frame)
    total = 0
    total += score_without_bonus
    total += next_frame.first_shot.score if strike? || spare?
    total += next_frame.second_shot.score if strike?
    total += after_next_frame.first_shot.score if !after_next_frame.nil? && strike? && next_frame.strike?
    total
  end
end
