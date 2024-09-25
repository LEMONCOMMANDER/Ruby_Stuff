friends = ["frank", "bill", "james"]
blank = Array[]
puts friends
puts friends.class
puts "blank is "
puts blank.class

puts ""
#appending
blank.append("yes")
#puts blank
blank.append(["1",2, 4])
blank.append("system")
puts ""
puts blank
puts "index and index"
puts blank[1][2] # should be 4

#can reverse with .reverse() or sort with .sort()

#    HASHES --- these are dictionaries or objects 
# IMPORTANT -- the syntax for key:value in ruby is key => value
puts""
example_hash = {}
example_hash["test"] = 1
puts "example hash adding"
puts example_hash
puts "adding some more and using [] to get a key to get a value"
example_hash["test2"] = 2
example_hash["test3"] = 3
example_hash["test4"] = 4
puts "using example_hash[\"test3\"] -- should equal 3"
puts example_hash["test3"]

# using symbols is the same as key -- symbol uses :
puts "using a synmbol by adding :test5"
example_hash[:test5] = 5
puts example_hash[:test5]