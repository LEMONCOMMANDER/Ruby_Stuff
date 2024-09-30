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

    def report(run, ttime, message)
        @end_time = Time.now
        @end_url = current_url
        execution_length = (@end_time - @start_time).round(3)
        load_time = (ttime - @start_time).round(3)
        ### recreates time telling already in rspec
        puts "_____________________________ EXECUTION TIME _____________________________"
        puts ""
        puts ("test #{run} starts at: #{@start_time} seconds")
        puts ("message \(optional\): #{message}")
        puts "..."
        if load_time == 0.00
            puts ("webdriver already loaded, no load time")
        else
            puts ("files took #{load_time} to load")
        end
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
        if @message == nil
            @message = "--"
        end
        @test_init.report(run, @ttime, @message)
        run += 1
    end
    ###############################################################################

=begin
    NOTE: the @ instance variables in the "it" blocks in respec are needed to pass information. Each "it" block techincally
    runs an instance of a "test" class behind the scenes - the hooks, or BEFORE |  AFTER tags and the test itself kind 
    operate like a class in that they don't share variables with each other. 
    
    This is why the @ instance variables are useful - it creates variables that can be shared amongst the "it", "before", and
    "after" statements in a test. (WON"T pass across "RSpec.describe" blocks)

    @ttime is needed because after each test, the variable needs to be passed to the "after" block - without this defintion, ttime
    is undefined. 
=end

    it "step 1 - will go to srs aqcuiom home page and clear the cookie" do
        visit("https://www.srsacquiom.com/")
        @ttime = Time.now # adjusts for page / files load time
        # puts @ttime # why needs to be instance variable? doesn't seem to work if not though...
        sleep (2)
        click_item = find('#onetrust-accept-btn-handler')
        expect(click_item.text).to eq("Allow All")
        click_item.click
        sleep(2)
    end 

    it "step 2 - verifies home page" do
        @ttime = Time.now
        @message = "verify homepage by elements"
        ## checks url 
        expect(current_url).to eq('https://www.srsacquiom.com/')
        ## checks carousel 
        expect(page).to have_selector('div.flex.flex-col.bg-neutral-200')
        ## checks chart
        expect(page).to have_selector('aside.chart')
        ## checks get started text
        expect(find("h4.text-green-800.pb-6").text).to eq("Gain the SRS Acquiom edge on your next deal.") 
    end

    it "step 3 - checks for mobile or desktop and then navigates to \"Our Solutions\"" do
        @ttime = Time.now 
        # mobile path
        if page.has_selector?('#nav-toggle', visible: true, wait: 3) == true # is the mobile menu visible
            @message = "MOBILE PATH"
            click_item = find('#nav-toggle', wait: 5)
            click_item.click
            # sleep(2)
            click_item = find('a.second-level-link:nth-child(1)', wait: 3) # mobile "our solutions"
            click_item.click
            ##
            click_item = find('#our-solutions-mobile > div:nth-child(2) > a:nth-child(4)') # mobile "deal dashboard"
            click_item.click
        # ----------------------------------
            # desktop path
        else
            # expect(page).to have_selector('#our-solutions-nav-link.dropdown-toggle-link')
            @message = "DESKTOP PATH"
            click_item = find('#our-solutions-nav-link.dropdown-toggle-link', wait: 3)
            click_item.click
            sleep(2)
            ##
            click_item = find('.our-solutions-nav-dropdown > div:nth-child(2) > a:nth-child(4)')
            click_item.click
            # sleep(2)
            ##
        end
        expect(current_url).to eq('https://www.srsacquiom.com/solutions/m-a-dashboard/')
    end
end
# ends part 1 


############### PART 2 - SRS AQUIOM DEAL DASHBOARD ############################

RSpec.describe "starts at \"deal dashboard\" and goes to \"solutions\" page" do
    include Capybara::DSL
    run = 4
    before(:each) do
        @test_init = TestUtility.new
        @test_init.setup()
    end
    after(:each) do
        if @message == nil
            @message = "--"
        end
        @test_init.report(run, @ttime, @message)
        run += 1
    end
########################################################

    it "checks the starting url for part 2 and confirms elements on page" do
        @ttime = Time.now
        @message = "Start of 2nd Rspec test suite"
        #check url 
        expect(current_url).to eq('https://www.srsacquiom.com/solutions/m-a-dashboard/')
        #check text above button 
        expect(find('h3.highlight-text').text).to eq('One system for the full deal lifecycle.')
    end

    it "goes to the element and clicks" do
        @ttime = Time.now
        click_item = find('a.min-w-\[157px\]:nth-child(3)')
        page.scroll_to(click_item, align: :center)
        sleep(2) # allow for scroll
        click_item.click 
        expect(current_url).to eq('https://www.srsacquiom.com/solutions/')
    end
end
# end part 3

################ PART 3 - navigating "solutions" to "contact us"

RSpec.describe "clicks on see it live and goes to contact page" do
    include Capybara::DSL
    run = 6
    before(:each) do
        @test_init = TestUtility.new
        @test_init.setup()
    end
    after(:each) do
        if @message == nil
            @message = "--"
        end
        @test_init.report(run, @ttime, @message)
        run += 1
    end
########################################################
    it "confirms the /solutions page" do
        @ttime = Time.now
        @message = "checks the url for part 3 and elements on page"
        ## check url
        expect(current_url). to eq('https://www.srsacquiom.com/solutions/')
        ## check "out solutions" at top
        expect(find('p.sm-eyebrow.text-neutral-50.pb-6').text).to eq("OUR SOLUTIONS") 
        ## check h1 text
        expect(find('h1.text-green-600').text).to eq("Welcome to modern deal management.")
    end

    it "clicks on \"see it live\"" do
        @ttime = Time.now
        find('.mb-10', wait: 3).click
        expect(current_url).to eq('https://www.srsacquiom.com/contact/')
    end
end
# end part 3

################################ part 4 contact us

RSpec.describe "confirms contact page and pulls information" do
    include Capybara::DSL
    run = 8
    before(:each) do
        @test_init = TestUtility.new
        @test_init.setup()
    end
    after(:each) do
        if @message == nil
            @message = "--"
        end
        @test_init.report(run, @ttime, @message)
        run += 1
    end
    # after(:all) do 
    #     @test_init.teardown()
    # end
    ## not needed as each session instance is destroyed anyway - the capibara driver stays open through everything.
    ##############################################

    it "confirms contact page" do 
        @ttime = Time.now
        @message = "final check"
         ## check url
        expect(current_url).to eq('https://www.srsacquiom.com/contact/')
        ## check h1 text
        expect(find('h1.text-purple-600').text).to eq('Get the answers you need.')
        ## check info for phone number
        phone = find('div.gap-3:nth-child(1) > div:nth-child(2) > p:nth-child(2) > a:nth-child(1)').text
        expect(phone).to eq('303.222.2080') 
        ## check operational hours
        op_hours = find('div.gap-3:nth-child(1) > div:nth-child(2) > p:nth-child(3)').text
        expect(op_hours).to eq("Monday–Friday \n6am–4:30pm PT\n9am–7:30pm ET") 
    end
end
