require 'capybara/rspec'
require 'selenium-webdriver'
require 'timeout' # can use for Timeout.timeout(x) but won't need to do it here

Capybara.default_driver = :selenium_chrome
Capybara.efault_max_wait_time = 10 # sets default wait time for find to 10 seconds


def setup()
     @start_time = Time.now #time is a built in ruby method
end

def teardown()
    @end_time = Time.now
    execution_length = (@end_time - @start_time)
end
 ####################################################################

def step1()
    puts ("step 1 START")
    begin # try
        visit ("https://www.google.com/")
        expect(page).to have_current_path("https://www.google.com/")
        expect(page).to have_selector(:id, "APjFqb")
        search_bar = find(:id, "APjFqb", wait: 10)
        fill_in("APjFqb",	with: "srs aquiom home page") 
        search_bar.send_keys(:enter)
        
        expect(page).to have_selector("cite.tjvcx.GvPZzd.cHaqb") # find the link on google for srs acquiom 
        find("cite.tjvcx.GvPZzd.cHaqb").click
        end_path = current_url    
       
    rescue Timeout::Error
        puts "_____________ER_____________"
        puts "ERROR on step1 - element load"
        puts  "_ _ _ _"
        puts Error
        puts "_____________ER_____________"
end

RSpec.describe "evaluates conditions in step 1", type: feature do
    it "goes to goolge, checks url, finds the search bar, and types in srs acquiom home page" do
        before(:each) do
            setup()
        end
        after(:each) do 
            teardown()
        end
    ################ SETUP ################
        expect(end_path).to eq("https://www.srsacquiom.com")
    end
end