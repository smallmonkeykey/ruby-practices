# frozen_string_literal: true

require 'etc'
require_relative 'fileinfo'

class LongFormat
  def initialize(filenames)
    @filenames = filenames
  end

  def list_files
    puts "total #{total_block}"

    @filenames.each do |filename|
      puts create_file_info(filename)
    end
  end

  private

  def create_file_info(filename)
    file_info = FileInformation.new(filename)

    print "#{file_info.find_type}#{file_info.find_mode} "
    print "#{file_info.build_stat[:nlink].rjust(find_max_size[:nlink] + 1)} "
    print file_info.build_stat[:owner].ljust(find_max_size[:owner] + 1)
    print "#{file_info.build_stat[:group].rjust(find_max_size[:group] + 1)} "
    print file_info.build_stat[:filesize].rjust(find_max_size[:filesize] + 1)
    print "#{file_info.build_stat[:time].rjust(find_max_size[:time] + 1)} "
    print file_info.build_stat[:filename]
  end

  def total_block
    @filenames.map { |filename| File.stat(filename).blocks }.sum
  end

  def find_max_size
    {
      nlink: @filenames.map { |filename| FileInformation.new(filename).build_stat[:nlink].size }.max,
      owner: @filenames.map { |filename| FileInformation.new(filename).build_stat[:owner].size }.max,
      group: @filenames.map { |filename| FileInformation.new(filename).build_stat[:group].size }.max,
      filesize: @filenames.map { |filename| FileInformation.new(filename).build_stat[:filesize].size }.max,
      time: @filenames.map { |filename| FileInformation.new(filename).build_stat[:time].size }.max
    }
  end
end
