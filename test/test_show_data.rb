#!/usr/bin/env ruby
# test-show-data.rb
#
# Alan K. Stebbens <aks@stebbens.org>

$:.unshift '.', '../test', 'test'

require 'helper'

require 'date'
require 'time'

array = [ 1, 2, 3, 10, 11, 12, 1.2, 34.567, 'apple', 'banana', 'cherry', :symbol1, :symbol2,
          Date.parse("2005-12-25"), Time.parse("2006-07-04 12:01:02") ]
show_data array

ahash = { 'a' => 'apple', 'b' => 'banana', 'c' => 'cherry' }
show_data ahash

nested = [ [ 'a', 1.2, 'b' ], [ 'd', :symbol ], [ [ 'ape', 'monkey', 'chimp' ], [ 'banana', 'leaves' ], 2.99 ] ]
show_data nested

combo = [ ahash, ahash.invert, nested ]
show_data combo

puts ''
puts "Testing Struct display"

Vars = Struct::new( :aVar, :varB, :varC, :reallyLongVarName, :andAnotherVar )
vars1 = Vars.new( 'firstValue', :secondValue, %w( the third value ), 
		   { :a => 'first', :nother => '2nd', :test => 'last item' },
		   nested )
show_data vars1

puts ''
puts "Testing OpenStruct display .."

require 'ostruct'
data = OpenStruct.new(ahash.invert)
show_data data

puts 'Testing a complicated OpenStruct ..'
data.complicated = vars1
show_data data

class TestObj
  attr_accessor :first, :second, :third
  def initialize( first='first thing', second='second thing', third='third thing')
    @first = first
    @second = second
    @third = third
    self
  end
end

testo1 = TestObj.new(1, 2, 3)
testo2 = TestObj.new('a', 'b', 'c')
testo3 = TestObj.new('I', 'II', 'III')
show_data testo1
show_data testo2
show_data testo3
testo4 = TestObj.new(testo1, testo2, testo3)
show_data testo4

exit
