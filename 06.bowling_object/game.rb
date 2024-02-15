# frozen_string_literal: true

require_relative 'frame'

class Game
  def initialize(marks)
     @marks = marks
  end

  def split_frames
    @frames = []
    i = 0
    9.times do
      first = @marks[i]
      second = nil
      if first == 'X'
        i += 1
      else
        second = @marks[i + 1]
        i += 2
      end
      @frames << Frame.new(first, second)
    end

    @frames << Frame.new(*@marks[i..])
  end

  def calculate_score
    totals = []
    split_frames.each_with_index { |frame, index| totals << (index < 9 ? calculate_normal_frame(frame, index) : frame.score_without_bonus) }
    totals.sum
  end

  private

  def calculate_normal_frame(frame, index)
    total = 0
    total += frame.score_without_bonus
    total += @frames[index + 1].first_shot.score if frame.strike? || frame.spare?
    total += @frames[index + 1].second_shot.score if frame.strike?
    total += @frames[index + 2].first_shot.score if index < 8 && frame.strike? && @frames[index + 1].strike?
    total
  end
end
