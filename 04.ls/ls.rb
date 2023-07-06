# frozen_string_literal: true

require 'optparse'

opt = OptionParser.new
params = {}
opt.on('-a') { |v| v }

opt.parse!(ARGV, into: params)

def get_filenames(params)
  if params[:a]
    Dir.entries('.').sort
  else
    Dir.glob('*')
  end
end

chunk_filenames = get_filenames(params)

ROWS = 3

def split_files_equally(chunk_filenames)
  sliced_chunk_filenames = chunk_filenames.each_slice((chunk_filenames.size.to_f / ROWS).ceil).to_a
  (sliced_chunk_filenames[0].size - sliced_chunk_filenames.last.size).times { sliced_chunk_filenames.last.push(' ') }
  sliced_chunk_filenames
end

def transpose_split_files(chunk_filenames)
  arry_max_size = chunk_filenames.map(&:size).max
  split_files_equally(chunk_filenames).transpose.each do |line|
    puts line.map { |file| file.ljust(arry_max_size + 1) }.join
  end
end

transpose_split_files(chunk_filenames)
