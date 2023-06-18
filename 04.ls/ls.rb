# frozen_string_literal: true

filenames = Dir.glob('*')

ROWS = 3

arry = filenames.each_slice((filenames.size.to_f / ROWS).ceil).to_a

def add_space(arry)
  (arry[0].size - arry.last.size).times { arry.last.push(' ') }
end

add_space(arry)

arry_size = filenames.map(&:size)

def transpose_arry(arry, arry_size)
  arry.transpose.each do |line|
    puts line.map { |file| file.ljust(arry_size.max + 1) }.join
  end
end

transpose_arry(arry, arry_size)
