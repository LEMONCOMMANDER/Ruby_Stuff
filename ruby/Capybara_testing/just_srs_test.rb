require 'capybara/dsl'
require 'rspec'
require 'selenium-webdriver'

Capybara.default_driver = :selenium_chrome
Capybara.default_max_wait_time = 10

class TestUtility # not really necessary to build a class but doing it for practice
    include Capybara::DSL 
    def setup() 
        @start_time = Time.now #time is a built in ruby method
    end

    def report(run, ttime)
        @end_time = Time.now
        @end_url = current_url
        execution_length = (@end_time - @start_time).round(3)
        load_time = (ttime - @start_time).round(3)
        ### recreates time telling already in rspec
        puts "_____________________________ EXECUTION TIME _____________________________"
        puts ""
        puts ("test #{run} starts at: #{@start_time} seconds")
        puts "..."
        puts ("files took #{load_time} to load")
        puts ("the lenght of this test was: #{execution_length} seconds")
        puts ("end url of test: #{@end_url}")
        puts ""
        puts "_____________________________ EXECUTION TIME _____________________________"
    end

    def teardown()
        Capybara.reset_sessions! # clears any files or cookies related to the browser session
    end
end

####################################################################################################### TESTS START #### 
############################################################################################ TESTS START ###############
################################################################################# TESTS START ##########################

RSpec.describe "visits SRS website and navigates to deal dashboards" do 
    include Capybara::DSL
    run = 1
    before(:each) do
        @test_init = TestUtility.new
        @test_init.setup()
    end
    after(:each) do
        # @run = 1
        @test_init.report(run, @ttime)
        run += 1
    end
    # after(:all) do 
    #     @test_init.teardown()
    # end
    ###############################################################################
    it "step 1 - will go to srs aqcuiom home page and clear the cookie" do
        visit("https://www.srsacquiom.com/")
        @ttime = Time.now # adjusts for page / files load time
        # puts @ttime # why needs to be instance variable? doesn't seem to work if not though...
        click_item = find('#onetrust-accept-btn-handler')
        expect(click_item.text).to eq("Allow All")
        click_item.click
        sleep(2)
    end 

    it "step 2 - verifies home page" do
        @ttime = Time.now
        # puts "verify bit starts..."
        # puts (Time.now)
        expect(page).to have_selector('div.flex.flex-col.bg-neutral-200')
    end

    it "step 3 - checks for mobile or desktop and then navigates to \"Our Solutions\"" do
        @ttime = Time.now
        if page.has_selector?('#nav-toggle', visible: true) == true # is the mobile menu visible
            click_item = find('#nav-toggle', wait: 5)
            click_item.click
            # sleep(2)
            click_item = find('a.second-level-link:nth-child(1)', wait: 5) # mobile "our solutions"
            click_item.click
            ##
            click_item = find('#our-solutions-mobile > div:nth-child(2) > a:nth-child(4)')
            click_item.click
        end
    end
end





        #     click_item = find('#nav-toggle', wait: 2) # checks for mobile menu
        #     click_item.click
        #     sleep(3)
        # rescue => e
        #     puts "error is "
        #     puts e
        # end 
        # begin 
        #     click_item = find('a.second-level-link:nth-child(1)')
        # rescue => e
        #     puts "error is "
        #     puts e 
        # end
#     end
# end



# class Srs
#     include Capybara::DSL

#     def to_srs()
#         visit("https://www.srsacquiom.com/")
#         # sleep(3) 
#     end

#     def clear_cookie()
#         click_item = find('#onetrust-accept-btn-handler')
#         click_item.click
#         sleep(2)
#     end

#     def check_mobile()
#         begin
#             click_item = find('#nav-toggle', wait: 2)
#             click_item.click
#             sleep(3)
#         rescue => e
#             puts "error is "
#             puts e
#         end 
#         begin 
#             click_item = find('a.second-level-link:nth-child(1)')
#         rescue => e
#             puts "error is "
#             puts e 
#         end
#     end

# end

# search = Srs.new
# search.to_srs()
# search.clear_cookie()
# search.check_mobile()