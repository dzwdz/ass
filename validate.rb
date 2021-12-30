#!/usr/bin/env ruby
# an .ass validator

require 'date'
require 'uri'

puts "this is just a prototype, don't take the output as ground truth\n\n"

idx = 0
valid = true
while line = gets
  idx += 1

  line.delete_suffix! "\n"
  next if line == ""     # empty lines
  next if line[0] == '#' # comments

  date, uri, title = line.split("\t", 3)

  begin
    Date.iso8601 date
    URI.parse uri

    raise Date::Error if date.strip != date # TODO doesn't work
    raise URI::InvalidURIError if uri.empty?

  rescue Date::Error
    puts "#{idx}: #{line}"
    puts "  invalid date!\n\n"
    valid = false
  rescue URI::InvalidURIError
    puts "#{idx}: #{line}"
    puts "  invalid URI!\n\n"
    valid = false
  end
end

puts "probably valid" if valid
