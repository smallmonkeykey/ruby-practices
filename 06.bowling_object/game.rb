# frozen_string_literal: true

require_relative 'frame'

class Game
  attr_reader :scores, :frames

  def initialize(result)
    @scores = result.split(',')
  end

  def split_frames
    @frames = []
    9.times do
      rolls = scores.shift(2)
      if rolls[0] == 'X'
        frames << Frame.new(rolls.first, nil)
        scores.unshift(rolls.last)
      else
        frames << Frame.new(*rolls)
      end
    end
    frames << Frame.new(*scores)
  end

  def calculate_total_score
    totals = []
    split_frames.each_with_index { |frame, index| index < 9 ? calculate_normal_frame(frame, index, totals) : totals << frame.sum_score }
    totals.sum
  end

  private

  def calculate_normal_frame(frame, index, totals)
    total = 0
    total += frame.sum_score
    total += frames[index + 1].first_shot.score if frame.strike? || frame.spare?
    total += frames[index + 1].second_shot.score if frame.strike?
    total += frames[index + 2].first_shot.score if index < 8 && frame.strike? && frames[index + 1].strike?
    totals << total
  end
end
