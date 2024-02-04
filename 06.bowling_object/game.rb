require_relative 'frame'

class Game
	attr_reader :scores, :frames

	def initialize(score)
		@scores = score.split(',')
	end

	def split_frames
	  @frames = []
		9.times do
			rolls = @scores.shift(2)
			if rolls[0] == "X"
				@frames << Frame.new(rolls.first, nil)
			  @scores.unshift(rolls.last)
			else
				@frames << Frame.new(*rolls)
			end
		end
		@frames << Frame.new(*@scores)
	end

	def total_score
		total = []
		split_frames.each_with_index { |frame, index| calculate_score(frame, index, total) }
		total.sum
	end

	def calculate_score(frame, index, total)
		if index < 9
			if index == 8 && frame.strike?
				total << frame.sum_score + frames[index + 1].first_shot.score + frames[index + 1].second_shot.score
			elsif frame.strike? && frames[index + 1].strike?
				total << frame.sum_score + frames[index + 1].first_shot.score + frames[index + 2].first_shot.score
			elsif frame.strike?
				total << frame.sum_score + frames[index + 1].first_shot.score + frames[index + 1].second_shot.score
			elsif frame.spare?
				total << frame.sum_score + frames[index +1].first_shot.score
			else
				total << frame.sum_score
			end
		else
				total << frame.sum_score
	  end
  end
end
