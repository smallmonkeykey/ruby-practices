# frozen_string_literal: true

require_relative 'ls'

params = ARGV.getopts('alr')
ls = Ls.new(params)
ls.list_files
