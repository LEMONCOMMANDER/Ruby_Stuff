# methods in the video - this is function 

def getname()
    puts ("what is your name?")
    name = gets.chomp()
    return name 
end


def sayhi(name)
    puts ""
    puts "hi " + name
    puts""
end

def check(var)
    num = nil
    if var.to_i == 1 or var.to_i == 2
        return
    end
    while var.to_i != 1 or var.to_i != 2
        puts "that ain't gonna fly! do it right this time"
        puts "pick a number 1 or 2"
        num = gets.chomp() 
        if num.to_i == 1 or num.to_i == 2 
            return num
        end 
    end
end

def moreinfo()
    puts "choose a number, 1 or 2"
    gender = gets.chomp()
    num = check(gender)
    if num != nil
    gender = num
    end
    puts "choose another number between 1 or 2"
    height = gets.chomp()
    num = check(height)
    if num != nil
        height = num
    end
    puts "choose a 3rd number between 1 or 2"
    living = gets.chomp()
    num = check(living)
    if num != nil
        living = num
    end
    return [gender.to_i, height.to_i, living.to_i]
end

name = getname()
sayhi(name)
info = moreinfo()


### ------------------------------------
# IF STATEMENTS

=begin Syntax
    the syntax for an if statement goes if / end . in between you can have elif and else, but the block must always end with end:
        if <condition>
            <event>
        elsif <condition 2>
            <event>
        else
            <event>
        end
=end 

if info[0] == 1
    ismale = true
else 
    ismale = false
end
if info[1] = 1
    istall = true
else 
    istall = false
end
if info[2] = 1
    alive = true
else
    alive = false
end

def story(name="bob-bot", ismale = nil, istall=nil, alive=nil, day_name="thursday")
    puts ""
    if ismale == nil and istall == nil and alive ==nil 
        puts "i guess im not the only robot here ey?"
        puts "no story for you"
        puts "try again later"
        return
    end
    if ismale == true and alive == true
        if istall == true
            print ("#{name}, you are a tall male, and luckily you are living")
        
        else
            print ("#{name}, you are a male and alive but you ain't that tall...").chomp()
        end
    elsif ismale == true and alive != true
            if istall == true
                print ("#{name}, you were a tall male but you aint nothin' no more").chomp()
            else
                print ("#{name}, you were a small dead man!").chomp()
            end
    else
        puts "#{name}, since you are not a man, the sexist capatalistic machine discriminates against you and your metrics are of no concern to it"  
        print "we are sincerely sorry that our corrupt controls programmed us to be such a small minded machine"  
        puts"."
        puts"."
        puts"."
        puts "at least its #{day_name}"
    
    end
end

### ---------------- CASE 
=begin CASE context
if you need to check one var against many options, like days of the week, you can use the case method. This is similar to SmartSuite


=end

def getday(day=nil) #day is nothing if not specified 
    puts "... right, one more question:"
    puts "what day is it?"
    puts""
    day = gets.chomp()
    day = day.downcase()
    day_name = ""
    days = ["monday", "mon", "tuesday", "tue", "wednesday", "wed"]
    if !days.include?(day)  #if day not in days but ruby syntax !!!!!!!!!!!!!!!
        day_name = "it's not a monday, tuesday, or wednesday..."
    else
        case day
            when "mon", "monday" # not using the or operator or ||, but , with case
                day_name = "monday"
                # could be its own block of code
                # spanning several lines as needed...
            when "tue", "tuesday"
                day_name = "tuesday"
            when "wed", "wednesday" # tried to assign one = when "mon"... || this syntax doesn't work 
                day_name = "wednesday"
            else # should never trigger
                print ("did the else in CASE")
                day_name = "it's not a monday, tuesday, or wednesday..."
            # when !one == true and !two == true and !three == true # improper syntax | and would never trigger - here for learning 
            #     day_name = "it's not a monday, tuesday, or wednesday..."
        end
    end
    return day_name
end

day_name = getday()
story(name, ismale, istall, alive, day_name)