# user inputs 

=begin gets

takes the user input in terminal 

=end

puts "enter your name"
name = gets 
puts ("hello " + name + ", you are cool") #after a variable,  ruby inserts a new line. this can be resolved with .chomp()
puts""

# ---->
puts "give me another name - this time with .chomp()"
name = gets.chomp() # gets rid of new line 
puts ("hello " + name + ", you are cool")
puts""

# mult inputs
puts "enter your name"
name = gets.chomp() 
puts "enter your age"
age = gets.chomp() 
puts ("hello " + name + ", you are " + age) #input is always a string