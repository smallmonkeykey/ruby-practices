# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X'
    shots << 10 << 0
  else
    shots << s.to_i
  end
end

frames = []
shots.each_slice(2) do |s|
  s.delete(0) if s[0] == 10
  frames << s
end

point = 0

frames.each.with_index do |frame, i|
  point += frame.sum

  if frame[0] == 10 && i < 9
    if frames[i + 1] == [10] && frames[i + 2] == [10]
      point += 20
    elsif frames[i + 1] == [10]
      after_next_frame = frames[i + 2]
      point += 10 + after_next_frame[0]
    else
      point += frames[i + 1].sum
    end
  end

  if frame.sum == 10 && frame.size == 2 && i < 9
    next_frame = frames[i + 1]
    point += next_frame[0]
  end
end

puts point
