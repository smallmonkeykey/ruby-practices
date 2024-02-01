require_relative 'shot'

class Frame
	attr_reader :first_shot, :second_shot, :third_shot

  def initialize(first_mark, second_mark, third_mark = nil)
		@first_shot = Shot.new(first_mark)
		@second_shot = Shot.new(second_mark)
		@third_shot = Shot.new(third_mark)
  end

	def score
		score = @first_shot.score + @second_shot.score
		score += @third_shot.score if @third_shot.score != 0
		score
	end
end
