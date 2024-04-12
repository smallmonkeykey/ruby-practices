# frozen_string_literal: true

require 'optparse'
require_relative 'longformat'
require_relative 'shortformat'

class Ls
  def initialize(options)
    @options = options
    @filenames = create_filenames
  end

  def list_files
    format_class = @options['l'] ? LongFormat : ShortFormat
    format_class.new(filenames).list_files
  end

  private

  def create_filenames
    filenames = Dir.glob('*')
    filenames = Dir.entries('.').sort if @options['a']
    filenames = filenames.reverse if @options['r']
    filenames
  end
end
