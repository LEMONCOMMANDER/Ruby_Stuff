=begin
class = google 
    def step1 - open google in chromedriver and find search bar element
        # unit test: confrim url, confirm search elelent 
    def step2 - enter search term into search bar element and hit enter
        # unit test: confirm entry term 
    def step3 - confirm search url and srs url in google. Click to go to SRS website
        # unit test: check words in search bar, check url to click on, check desintation url 
end

class = srs 
    def setp 4 - accept cookies 
        # unit test = test srs url for homepage, find element, confirm that element goes away, check presence of caroselle  
    def step 5 - determine if hamburger menu is there (mobile)
        # unit test = assert that it is there - set error for negtive test (it isn't there)
    def step 6 - on result of hamurger menu, navigate mobile or desktop version to | our solutions > deal dashboard
        # unit test: assert that div of dropdown menu is present, check desintation url to dashboard
    def step 7 - scroll to see the full suite and click on element 
        # unit test: assert that element is present, assert that after scroll, element is in viewport, verify presence of element
    def step 8 - click on see it live
        # unit test: verify correct url (solutions), verify presnece of element 
    def setp 9 - extract phone number and op hours 
        # unit test - verify that the information grabbed is correct, verify url (contact)
end
=end

require "capybara/dsl"
require "rspec"
require 'selenium-webdriver'

Capybara.default_driver = :selenium_chrome
Capybara.default_max_wait_time = 10

class GoogleSearch
    include Capybara::DSL # allows use of capybara inside the class codein
    def initialize()
        @searches = 0
        @url_list = {}
    end

    def step1() # go to google
        @searches += 1 
        destination = "https://www.google.com"
        @url_list["search #{@searches}"] = destination
        visit(destination)
        puts @url_list
        # sleep(5)
    end

    def step2(input) # searches for input
        input = "srs acquiom home page"
        search_bar = find(:id, "APjFqb", wait: 10)
        fill_in("APjFqb", with: input )
        search_bar.send_keys(:enter)
        # sleep(5)
    end

    def step3()
        @searches += 1 
        destination = current_url
        # puts "current url is " + destination
        @url_list["search #{@searches}"] = destination # should be a google url 
       
        # click_item = find(:css, ".tjvcx.GvPZzd.cHaqb", wait: 3) 
        # click_item = driver.find_element(By.CSS_SELECTOR, "cite.tjvcx.GvPZzd.cHaqb")

        begin
            # Adjust the wait time as necessary
            find(:css, 'cite.tjvcx.GvPZzd.cHaqb', wait: 10).click
        rescue Capybara::ElementNotFound => e 
            puts e
            puts "Element not found"
        end
        # click_item = find_link("https://www.srsacquiom.com")
        # # click_link(".tjvcx.GvPZzd.cHaqb") # seperates for testing purposes 
        # click_item.click
        # sleep(2)
        # # puts @url_list
        # # sleep(3)

    end

end 


search =GoogleSearch.new
search.step1()
search.step2("test")
search.step3()

# src.rb
# class GoogleSearch
#     include Capybara::DSL  # Include Capybara's methods for web interaction
  
#     def visit_google
#       visit "https://www.google.com"
#     end
  
#     def search_for(term)
#       search_bar = find(:id, "APjFqb", wait: 10)
#       fill_in("q", with: term)
#       search_bar.send_keys(:enter)
#     end
# end
  
# search = GoogleSearch.new
# search.visit_google()


 
  