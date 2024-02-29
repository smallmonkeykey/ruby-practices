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
    split_frames.each_with_index do |frame, index|
      next_frame = @frames[index + 1]
      after_next_frame = @frames[index + 2]
      totals << (index < 9 ? frame.calculate_normal_frame(next_frame, after_next_frame) : frame.score_without_bonus)
    end
    totals.sum
  end
end
