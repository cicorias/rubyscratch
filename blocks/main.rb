#!/usr/bin/env ruby

require './core'


run_block do |parm1|
  puts "you said #{parm1}"
end


run_yield do |p|
  puts "you got #{p}"
end

run_yield { |p,n|
  puts "braces got #{p}"
  puts n.inspect
}