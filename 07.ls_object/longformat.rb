# frozen_string_literal: true

require 'etc'
require_relative 'fileinfo'

class LongFormat
  def initialize(filenames)
    @file_infos = filenames.map { |filename| FileInformation.new(filename) }
  end

  def list_files
    puts "total #{total_block}"

    max_size_map = calc_max_size

    @file_infos.each do |file_info|
      print_file_info(file_info, max_size_map)
      puts
    end
  end

  private

  def print_file_info(file_info, max_size_map)
    print "#{file_info.find_type}#{file_info.find_mode} "
    print "#{file_info.build_stat[:nlink].rjust(max_size_map[:nlink] + 1)} "
    print file_info.build_stat[:owner].ljust(max_size_map[:owner] + 1)
    print "#{file_info.build_stat[:group].rjust(max_size_map[:group] + 1)} "
    print file_info.build_stat[:filesize].rjust(max_size_map[:filesize] + 1)
    print "#{file_info.build_stat[:time].rjust(max_size_map[:time] + 1)} "
    print file_info.build_stat[:filename]
  end

  def total_block
    @file_infos.map(&:calc_block).sum
  end

  def calc_max_size
    {
      nlink: @file_infos.map { |file_info| file_info.build_stat[:nlink].size }.max,
      owner: @file_infos.map { |file_info| file_info.build_stat[:owner].size }.max,
      group: @file_infos.map { |file_info| file_info.build_stat[:group].size }.max,
      filesize: @file_infos.map { |file_info| file_info.build_stat[:filesize].size }.max,
      time: @file_infos.map { |file_info| file_info.build_stat[:time].size }.max
    }
  end
end
