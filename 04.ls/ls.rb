# frozen_string_literal: true

filenames = Dir.glob('*')

ROWS = 3

divided_arry = filenames.each_slice((filenames.size.to_f / ROWS).ceil).to_a

def fill_blank_to_matrix_shape(divided_arry)
  (divided_arry[0].size - divided_arry.last.size).times { divided_arry.last.push(' ') }
end

fill_blank_to_matrix_shape(divided_arry)

divided_arry_size = filenames.map(&:size)

def transpose_divided_arry(divided_arry, divided_arry_size)
  divided_arry.transpose.each do |line|
    puts line.map { |file| file.ljust(divided_arry_size.max + 1) }.join
  end
end

transpose_divided_arry(divided_arry, divided_arry_size)
