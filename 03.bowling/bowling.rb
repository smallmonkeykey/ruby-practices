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

binding.break

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
