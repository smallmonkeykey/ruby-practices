require_relative 'frame'

class Game
	attr_reader :scores

	def initialize(score)
		@scores = score.split(',')
	end

	def split_frames

	end
end
