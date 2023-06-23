# frozen_string_literal: true

filenames = Dir.glob('*')

ROWS = 3

sliced_filenames = filenames.each_slice((filenames.size.to_f / ROWS).ceil).to_a

def fill_blank_to_matrix_shape(sliced_filenames)
  (sliced_filenames[0].size - sliced_filenames.last.size).times { sliced_filenames.last.push(' ') }
end

fill_blank_to_matrix_shape(sliced_filenames)

arry_max_size = filenames.map(&:size).max

def transpose_sliced_filenames(sliced_filenames, arry_max_size)
  sliced_filenames.transpose.each do |line|
    puts line.map { |file| file.ljust(arry_max_size + 1) }.join
  end
end

transpose_sliced_filenames(sliced_filenames, arry_max_size)
