require 'capybara/dsl'

class Metrics
    include Capybara::DSL
######################################################################################################## 
    def initialize()
        puts "Metrics: use .help() for details"
        @run = 1
    end

    def help()
        puts <<~HEREDOC
                Provides additional insights into each test in an RSpec envionrment. Intended for [before / after](:each)
                
                At the beginning of each test, a time stamp will be taken (start).
                After a webdriver request is made, a variable called ttime should take a time stamp to pass to report(). 
                This will calculate the load time of the webdriver. The full test length will also be calclated.
                
                    start(): Called at the beggining of each test - time stamp

                    report(ttime, message): takes ttime and optional message. Called at the tend of each test - metrics
            HEREDOC
    end

    def start() 
        @start_time = Time.now 
    end

    def report(ttime, message)
        @end_time = Time.now
        if current_url == nil or ""
            @end_url = "NO URL"
        else
            @end_url = current_url
        end
        execution_length = (@end_time - @start_time).round(3)
        load_time = (ttime - @start_time).round(3)
        if ttime == nil
            t = "none"
            load_time = 0.00 
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
                puts ("files took #{load_time} to load")
        end
            puts ("the lenght of this test was: #{execution_length} seconds")
            puts ("end url of test: #{@end_url}")
            puts ""
            puts "_____________________________ EXECUTION TIME _____________________________"
            puts ""
        @run += 1
    end
end