#working with strings

puts "hello world"
puts "hello \" world"

# the above demonstrates how to use literal characters inside quotes
#\n is new line:
puts ""
puts "hello\nworld"

=begin 
stings have methods just like in python = javascript. Vidoe will cover the following. Mehtods use . notations
=end

phrase = "hello world"
puts "upper case"
puts phrase.upcase() #function () are optional

puts ""
puts "lower case"
puts phrase.downcase()
puts ""

phrase = "n hello n world"
puts "tr"
puts phrase.tr("n", "")
# string.tr(from_str, to_str)
# from_str is a string of characters you want to replace.
# to_str is a string of characters you want to replace them with.

puts ""
puts "strip"
phrase = "     | hello         world |    "
puts phrase.strip()
# strip takes no argument but only works on leading and trailing whitespace

puts ""
puts "include"
phrase = "hello world"
puts phrase.include? "world" #note that ? and ! are both method operators that tell the method how to run - more research is needed
puts phrase.include? "WWorld"
puts""

puts "string indexing"
puts phrase[4] #indexing still starts as 0
puts "using length"
max = phrase.length() #integer
puts "max lenght of string is: " +  max.to_s #string
puts "index range"
puts phrase[3,max] # start, end
puts "negaitve index"
puts phrase[-1] #goes from the end of the string
puts "using .index"
puts phrase.index("l") #first instance of the parameter in the string