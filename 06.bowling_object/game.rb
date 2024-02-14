# frozen_string_literal: true

require_relative 'frame'

class Game
  attr_reader :scores, :frames

  def initialize(result)
   @scores = result.split(',')
  end

  def split_frames
    @frames = []
		i = 0
		9.times do
			first = scores[i]
			second = nil
			if first == "X"
				i += 1
			else
				second = scores[i + 1]
				i += 2
			end
			frames << Frame.new(first, second)
    end

    frames << Frame.new(*scores[i..])
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
