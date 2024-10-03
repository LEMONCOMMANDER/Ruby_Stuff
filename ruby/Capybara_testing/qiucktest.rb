require_relative 'login_info'
require 'pp'

creds = Login.new

puts "creds:"

c_list = creds.get_creds()
# pp c_list


puts ""
puts "_______________________"
puts ""

a = creds.new_cred?(:test4, "email", "PW")
# puts "added new cred"
puts ""
puts "________________________"
puts "creds:"
c_list = creds.get_creds()
# pp c_list
puts "________________________"
puts ""
puts a
if a == true
    puts "!!!!!!!!!!!!!!!!!!! a is ok !!!!!!!!!!!!!!!!!!!"
else 
    puts "!!!!!!!!!!!!!!!!!!! a didn't work !!!!!!!!!!!!!!!!!!"
end
sleep (5)
b = creds.delete_cred?("test4")
c = creds.delete_cred?("test")

if b == true
    puts "b is true"
else 
    puts "b is false"
end

if c == true
    puts "c is true"
else 
    puts "c is false"
end


c_list = creds.get_creds()
# pp c_list

puts "______________________________________________________________"

creds.help()

