# frozen_string_literal: true

require 'debug'

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X' # strike
    shots << 10 << 0
  else
    shots << s.to_i
  end
end



frames = []
shots.each_slice(2) do |s|
  if s[0] == 10
    s.delete(0)
    frames << s
  else
    frames << s
  end
end

p frames
#binding.break

point = 0
frames.each.with_index do |frame,i|
  p point
  point += frame.sum
  
  if frame[0] == 10 && i < 9
    if frames[i+1] == [10] && frames[i+2] == [10]
      point += 20
    elsif frames[i+1] == [10]
      after_next_frame = frames[i+2]
      point += 10 + after_next_frame[0]
    else
      point += frames[i+1].sum
    end
  end

end

p point




=begin
point = 0
frames.each.with_index do |frame,i|
  point += frame.sum
  if frame[0] == 10
    i += 1
    if frames[i].nil? == false
      point += frames[i].sum
    end

  if frame.sum == 10
    i += 1
    next_frame = frames[i]
    if frames[i].nil? == false
      point += next_frame[0]
    end
  end
end
=end

puts point


# ruby bowling.rb X,X,X,X