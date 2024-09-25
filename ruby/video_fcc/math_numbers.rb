# Math & Numbers

a = 2 ** 5 # this is exponential - 2 ^ 5 = 25
b = 10 % 3 # modulus operator, only shows the reminder - = 1
c = 14 % 5 # = 4 -- 14 / 5 = 2.8, take int as 2, then 2 * denominator (or 5) = 10, finally numerator (14) - 10 = 4
d = 14 / 5 

# when using puts, use ( ) just like python print for best practices

# math mehtods

num = -20
puts num.abs() # absolute value

num = 20.6.round() # to closest whole number | can use ceil() to always round up or | floor() to always round down
puts num

# BUILT IN TO RUBY IS MATH

num = 20 
puts ("square root")
puts Math.sqrt(3) # square root 
puts""
puts ('log')
puts Math.log(4)
puts("")

#wehn you want floats, use a float in the equation
num = 10
puts("intger - 10/7 - output is rounded to int")
puts (num / 7)
puts("float - 10/7.0 - output shows the decimals")
puts (num/7.0)