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

=begin
point = 0
frames.each do |frame|
  if frame[0] == 10 # strike
    point += 30
  elsif frame.sum == 10 # spare
    point += frame[0] + 10
  else
    point += frame.sum
  end
end
puts point
=end

point = 0
frames.each.with_index do |frame,i|
  point += frame.sum
  if frame[0] == 10
    if frames[i].nil? == false
      point += frames[i].sum
    end
  elsif frame.sum == 10
    i += 1
    next_frame = frames[i]
    if frames[i].nil? == false
      point += next_frame[0]
    end
  end
end
puts point


# ruby bowling.rb X,5,4,X,2,3,6,3