# frozen_string_literal: true
ALL_PINS = 10

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  s == 'X' ? shots << ALL_PINS << 0 : shots << s.to_i
end

frames = []
shots.each_slice(2) do |s|
  s.delete(0) if s[0] == ALL_PINS
  frames << s
end

point = 0

frames.each.with_index do |frame, i|
  point += frame.sum

  if frame[0] == ALL_PINS && i < 9
    if frames[i + 1] == [ALL_PINS] && frames[i + 2] == [ALL_PINS]
      point += 20
    elsif frames[i + 1] == [ALL_PINS]
      point += ALL_PINS + frames[i + 2][0]
    else
      point += frames[i + 1].sum
    end
  end

  if frame.sum == ALL_PINS && frame.size == 2 && i < 9
    point += frames[i + 1][0]
  end
end

puts point
