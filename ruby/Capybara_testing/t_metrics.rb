require 'capybara/dsl'

class Metrics
    include Capybara::DSL
######################################################################################################## 
    def initialize()
        puts "--------------------------------------"
        puts "  Metrics: use .help() for details"
        puts "--------------------------------------"
        @run = 1
    end

    def help()
        puts <<~HEREDOC
                Provides additional insights into each test in an RSpec envionrment. Intended for [before / after](:each)
                
                At the beginning of each test, a time stamp will be taken (start).
                After a webdriver request is made, a variable called ttime should take a time stamp to pass to report(). 
                This will calculate the load time of the webdriver. The full test length will also be calclated.
                
                    start(): Called at the beggining of each test - time stamp
                   ----------

                    report(ttime, message): takes ttime and optional message. Called at the tend of each test - metrics
                   ------------------------
            HEREDOC
    end

    ##
    # call .help() function for more details...
    #
    # takes no arguments, should be used in a before(:each) block to catpure time at the start of each test
    #
    def start() 
        @start_time = Time.now
    end

    ##
    # call .help() function for more details...
    #
    # (ttime=nil, message)
    # takes ttime when called which should be a time stamp after a url change OR the beggining of an it block
    # takes an optional message to display in the report
    #
    def report(ttime=nil, c_url, message)
        @end_time = Time.now
        if c_url == nil or c_url == ""
            puts(c_url)
            @end_url = "NO URL"
        else
            @end_url = c_url
        end
        execution_length = (@end_time - @start_time).round(3)
        if ttime == nil
            t = "none"
            load_time = 0.00 
        else
            load_time = (ttime - @start_time).round(3)
        end
            puts ""
            puts "_____________________________ EXECUTION TIME _____________________________"
            puts ""
            puts ("test #{@run} starts at: #{@start_time} seconds")
            puts ("message \(optional\): #{message}")
            puts "..."
        if t == "none"
                puts ("!!! NO ttime STAMP TAKEN !!!") 
        end
        if load_time == 0.00
                puts ("No ttime or webdriver already loaded... no load time")
        else
                puts ("driver took #{load_time} to load")
        end
            puts ("the lenght of this test was: #{execution_length} seconds")
            puts ("end url of test: #{@end_url}")
            puts ""
            puts "_____________________________ END | EXECUTION TIME ________________________"
            puts ""
        @run += 1
    end
end