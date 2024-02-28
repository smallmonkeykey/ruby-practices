# frozen_string_literal: true

require 'etc'

class LongFormat
  MODE_TABLE = {
     0 => '---',
     1 => '--x',
     2 => '-w-',
     3 => '-wx',
     4 => 'r--',
     5 => 'r-x',
     6 => 'rw-',
     7 => 'rwx'
  }.freeze

  def initialize(filenames)
    @filenames = filenames
  end

  def list_files
    puts "total #{total_block}"

		@filenames.each do |filename|
			stat = File.stat(filename)
			puts create_file_info(stat, filename)
		end
  end

  def total_block
    @filenames.map { |filename| File.stat(filename).blocks }.sum
  end

	def format_type(file_stat)
    file_stat.directory? ? 'd' : '-'
  end

	def create_file_info(stat, filename)
			print "#{format_type(stat)}#{file_mode(stat)}"
			print "#{hard_link(stat)}"
			print "#{owner(stat)}"
			print "#{group(stat)}"
			print "#{file_size(stat)}"
			print "#{time(stat)}"
			print "#{filename}"
	end

	def file_mode(stat)
		permissions = stat.mode.to_s(8).slice(-3, 3).to_i.digits.reverse
		permissions.map { |permission| MODE_TABLE[permission] }.join
	end

	def hard_link(stat)
		stat.nlink.to_s.rjust(3)
	end

	def owner(stat)
		Etc.getpwuid(stat.uid).name
	end

	def group(stat)
		Etc.getgrgid(stat.gid).name
	end

	def file_size(stat)
		stat.size.to_s.rjust(6)
	end

	def time(stat)
		stat.mtime.strftime('%_m %_d %H:%M')
	end

end
