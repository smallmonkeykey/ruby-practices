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
      print_file_info(filename)
      puts
    end
  end

  private

  def print_file_info(filename)
    file_info = FileInformation.new(filename)
    max_size_map = calc_max_size

    print "#{file_info.find_type}#{file_info.find_mode} "
    print "#{file_info.build_stat[:nlink].rjust(max_size_map[:nlink] + 1)} "
    print file_info.build_stat[:owner].ljust(max_size_map[:owner] + 1)
    print "#{file_info.build_stat[:group].rjust(max_size_map[:group] + 1)} "
    print file_info.build_stat[:filesize].rjust(max_size_map[:filesize] + 1)
    print "#{file_info.build_stat[:time].rjust(max_size_map[:time] + 1)} "
    print file_info.build_stat[:filename]
  end

  def total_block
    @filenames.map { |filename| File.stat(filename).blocks }.sum
  end

  def calc_max_size
    @file_infos = @filenames.map { |filename| FileInformation.new(filename) }
    {
      nlink: @file_infos.map { |file_info| file_info.build_stat[:nlink].size }.max,
      owner: @file_infos.map { |file_info| file_info.build_stat[:owner].size }.max,
      group: @file_infos.map { |file_info| file_info.build_stat[:group].size }.max,
      filesize: @file_infos.map { |file_info| file_info.build_stat[:filesize].size }.max,
      time: @file_infos.map { |file_info| file_info.build_stat[:time].size }.max
    }
  end
end
