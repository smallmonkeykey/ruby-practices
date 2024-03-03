# frozen_string_literal: true

class FilePath
  require 'optparse'

  def initialize(params)
    @params = params
  end

  def create_filenames
    filenames = Dir.glob('*')
    filenames = Dir.entries('.').sort if @params['a']
    filenames = filenames.reverse if @params['r']
    filenames
  end
end
