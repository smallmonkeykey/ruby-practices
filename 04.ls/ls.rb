# frozen_string_literal: true

pwd_dirs_files = Dir.glob('*')

ROWS = 3

arry = pwd_dirs_files.each_slice((pwd_dirs_files.size.to_f / ROWS).ceil).to_a

def add_space(arry)
  (arry[0].size - arry.last.size).times { arry.last.push(' ') }
end

add_space(arry)

arry_size = pwd_dirs_files.map(&:size)

def transpose_arry(arry, arry_size)
  arry.transpose.each do |line|
    puts line.map { |file| file.ljust(arry_size.max + 1) }.join
  end
end

transpose_arry(arry, arry_size)
