# drawing a shape - 12:01

=begin

some self study - =begin / =end is the doc string sytnax for ruby - ''' ''' in python
functions use def / end -- end is a key word that is used at the end of most structures if/then included
"#{}" is used for string interpelation 

=end
puts 'is'

print "hello world"
print ['hello', 'world']

puts "ok"

print "chocolate"
puts ""

=begin 
ruby has both print and puts - puts will always use a new line after the statement. Print simply returns things inline.
TAKEAWAY - from python, use puts as it acts like python print
=end


puts "   /|"
puts "  / |"
puts " /  |"
puts "/___|"
puts ""
puts ""

# BY nature, ruby is a syncronous langauge -  its does have some options for asyncronous functionality but not like js

VARIABLES = "VARIABLES"
# variable assignemnt is similar to python -- =, ==, ===, and .eql() are all uses of assignment / equality

name = "bill"
fruit = "apple"
puts "there was a dude named " + name +"."
puts "#{name} was very unahppy but..."
puts "one day " + "#{name}" + "went to the store"
puts "and purchased some #{fruit}, which made him happy"
puts "he then changed his name to " + name="fred" +  "." 

# LETS MOVE ON TO DATATYPES

DATATYPES = "datatypes"
=begin CONVERSIONS

Conversion	        Method
Boolean             = !!value -- determines false or true on if the object assigned is truthy or falsy 
Integer to String	.to_s
String to Integer	.to_i -- will cut off any string components | stops at the first non integer
String to Float	    .to_f
Symbol to String	.to_s
String to Symbol	.to_sym, .intern
Float to Integer	.to_i
Integer to Float	.to_f
check type          .class
Check Length	    .length, .size
Check Empty	        .empty?

=end
# nil means no value

puts ""
puts "number test"
number = 4
puts number.to_f
puts ''
puts "string test"
puts number.to_s