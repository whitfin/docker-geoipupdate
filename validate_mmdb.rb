#!/usr/bin/env ruby

require 'mmdb'

file_name = ARGV[0]
test_ip = ARGV[1]

if file_name.nil? || test_ip.nil?
  STDERR.puts <<-ERROR
  ArgumentError:
          Usage: #{$0} <file_name> <ip>
  ERROR
  exit 1
end

if file_name.start_with?('/')
  file = file_name
else
  file = File.expand_path("../#{file_name}", File.dirname(__FILE__))
end

unless File.exist?(file)
  STDERR.puts "File Not Found: #{file}"
  exit 1
end

Mmdb.configure do |c|
  c.file_path = file
end

if Mmdb.query(test_ip).nil?
  STDERR.puts "Test query failed to find VPN for IP"
  exit 1
else
  puts "Passed! #{test_ip} found in #{file_name}"
end
