# all about for loops huzzah - lets get that syntax

friends = {:Kevin => 20, :Alice => 5, :Bill => 17, :Katie => 11}
modulator = [0.5, 1, 2]
interest = [1.5,3.0,5.0]
owed = 0
# hundred = []
# fifty = []
# twenty = []
# ten = []
# five = []
# one = []
cents = ""
your_total_cash = 0

for key, value in friends
    hundred = []
    fifty = []
    twenty = []
    ten = []
    five = []
    one = []
    puts key
    puts "... calculating friendship in dollars ..."
    sleep(2)
    mod_selector = modulator[rand(2)]
    owed = value * mod_selector

    #### EACH simple example - further syntax study is needed ####
    interest.each do |element| # practice using EACH - goes through all items in a container - good for things with >2 items
        puts "at #{element} interst rate, the total is: $" + (owed * element).to_s 
    end
    ###################

    puts ""
    f_i = interest[rand(2)]
    total = owed * f_i
    puts "#{key} is at a rate of " + f_i.to_s + " and owes: $" + total.to_s
    puts ""
    puts "make them pay?     yes/no"
    answer = (gets.chomp()).to_s
    if answer.downcase() == "yes"
        puts "cha-ching"
        while total > 0
            puts ("total is: ") + total.to_s
            if total >= 100
                hundred.append(1)
                total -= 100
            elsif total >= 50 and total < 100
                fifty.append(1)
                total -= 50
            elsif total >= 20 and total < 50
                twenty.append(1)
                total -= 20
            elsif total >= 10 and total < 20
                ten.append(1)
                total -= 10
            elsif total >= 5 and total < 10
                five.append(1)
                total -= 5
            elsif total >= 1 and total < 5
                one.append(1)
                total -= 1
            elsif total > 0 and total < 1  
                cents = "and change"
                total = 0
            end
        end
        puts ""
        puts "you get:"
        puts "____________________"
        if hundred.length() > 0
            puts (hundred.length).to_s + " $100 bill(s)" 
            your_total_cash += 100 
        end
        if fifty.length() > 0
            puts (fifty.length).to_s + " $50 bill(s)" 
            your_total_cash += 50 
        end   
        if twenty.length() > 0
            puts (twenty.length).to_s + " $20 bill(s)" 
            your_total_cash += 20 
        end        
        if ten.length() > 0
            puts (ten.length).to_s + " $10 bill(s)"
            your_total_cash += 10  
        end    
        if five.length() > 0
            puts (five.length).to_s + " $5 bill(s)" 
            your_total_cash += 5
        end    
        if one.length() > 0
            puts (one.length).to_s + " $1 bill(s)"
            your_total_cash += 1  
        end    
        if cents == "and change"
            puts cents
        end
    else 
        puts "it wasn't yes..."
        puts "so it was therefore no..."
        puts "and you are too nice"
        # return
    end
    puts ""
    puts ("your total cash so far is: $#{your_total_cash}")
    puts ""
end

if cents != "and change"
    cents = ""
end
puts ("today you made $#{your_total_cash} #{cents} - it sure is nice to have moneyba... I mean friends")

 