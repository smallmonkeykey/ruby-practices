# frozen_string_literal: true

require 'optparse'
require_relative 'filepath'
require_relative 'longformat'

class Ls
  NUMBER_OF_COLUMNS = 3

  def initialize(options)
    @options = options
    @filenames = create_filenames
  end

  def list_files
    @options['l'] ? LongFormat.new(@filenames).list_files : short_format
  end

  private

  def create_filenames
    filenames = Dir.glob('*')
    filenames = Dir.entries('.').sort if @options['a']
    filenames = filenames.reverse if @options['r']
    filenames
  end

  def short_format
    create_arranged_filenames.each do |row|
      puts row.map { |file| file.ljust(max_size + 2) }.join
    end
  end

  def create_arranged_filenames
    arranged_filenames = []
    column_size = (@filenames.size - 1) / NUMBER_OF_COLUMNS + 1
    column_size.times do |i|
      row = []
      NUMBER_OF_COLUMNS.times do
        row << @filenames[i]
        i += column_size
      end
      arranged_filenames << row.compact
    end
    arranged_filenames
  end

  def max_size
    @filenames.map(&:size).max
  end
end
