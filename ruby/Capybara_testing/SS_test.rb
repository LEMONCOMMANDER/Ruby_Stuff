require 'capybara/dsl'
require 'rspec'
require_relative 'login_info'
require_relative 't_metrics'

Capybara.default_driver = :selenium_chrome
Capybara.default_max_wait_time = 10

################################################## SETUP #######################################################
creds = Login.new
metrics = Metrics.new


RSpec.shared_context "setup / teardown" do 
    before(:each) do 
        metrics.start()
    end
    after(:each) do
        metrics.report(@ttime, @current_url, @message)
    end
    after(:all) do 
        Capybara.reset_sessions!
    end
end

################################################## TESTS #######################################################

RSpec.describe "A UI test on SmartSuite" do
    include Capybara::DSL
    include_context "setup / teardown"
#########################################################
    it "navigates to SmartSuite.com" do # 1
        visit("https://www.smartsuite.com/")
        @ttime = Time.now
        page.driver.browser.manage.window.maximize # full screen
        @current_url = page.current_url
            expect(find("img.logo")[:title]).to eq("SmartSuite Logo")# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ T1 | sign in button 
    end  # it 1 | goes to the website and clicks "sign in"

        ## look into working with windows in docs
    it "clicks 'sign in' on homepage and logsin with given credentials in the new window" do # 2
        @signin_window = window_opened_by do
            find("a#sign-in-header").click  
        end
        
        switch_to_window @signin_window

            expect(page.current_url).to eq("https://app.smartsuite.com/authenticate/login") # @@@@@ T2 | login page 
            @ttime = Time.now # stamps AFTER page loads
        @current_url = page.current_url
        find('input#username').set(creds.get_cred(:smartsuite)[0]) # username
        find('input#current-password').set(creds.get_cred(:smartsuite)[1]) # password
        find("button.auth-button.login-start__submit.full-width").click
    end # it 2  | enters credentials into new window

    it "Searches homepage for a 'SS UI test' solution or creates a new one" do # 3
            expect(page).to have_current_path("https://app.smartsuite.com/sr7y4774/home") # @@@@@ T3 | dashboard  
            @current_url = page.current_url
        find('[aria-label="Search Solutions"]').set("SS UI test")
    ################################################ searches for solution ####################################################
            expect(find("div.title:nth-child(1)").text).to eq('Solutions matching "SS UI test"') # @@@@@ T3 | dashboard
                # nth-child because second div is present and reads "No Results Found"

        if page.has_selector?("div.r-no-solution") == true # no results found 
            find("button.r-add-solution.r-add-solution--full-width.r-add-solution--cardview").click # new solution 
            find("div.menu-option.menu-option--icon-color-gray:nth-of-type(2)").click # new from scratch
            find("svg.solution-title__arrow.icon").click # options arrow
            find('input[aria-label="Write here"]').set("SS UI test").send_keys(:enter) # sets name 
        else
            # puts "url: #{current_url}"
                expect(page).to have_selector('div.solution-preview-card__body') # @@@@@ T4 | created solution exists?
                    ttime1 = Time.now
            find('div.solution-preview-card__body').click
                    ttime2 = Time.now
                    @message = "before click: #{ttime1}, after click: #{ttime2}, dif: #{(ttime2 - ttime1).round(3)} seconds"
                expect(page.current_url).to has_current_path?("/6712d0d71bc87a93047c497e")
                # expect(current_url).to eq("https://app.smartsuite.com/sr7y4774/solution/6712d0d71bc87a93047c497e/6712d0d71bc87a93047c4980/6712d0d71bc87a93047c4981")  
                # the solution url  || @@@@@ 5 | check proper solution 
        end 
    end # it 3 | navigates to or creates solution

    it "creates a new table in the solution, deletes the old one, and clears all fields" do # 4
        ## create a new table
        find("button.application-add-button").click # top + button
        find("div.application-add-options__scratch").click # from scratch
        find('[value]').set("SS UI table").send_keys(:enter)
        find('div.application-navbar-item[aria-label="SS UI table"]').click
        
        ## deletes the old table
        find('div.application-navbar-item__link[aria-label="Table 1"]').click
            sleep (1)
            find('div.application-navbar-item__link[aria-label="Table 1"]').click # needs to click twice
        find('div.menu-option[aria-label="Delete Table"]').click 
        find('ss-ui-row.row > :nth-child(2)').click # yes
        
        ## delete the old fields
        find('[aria-label="Assigned To"] > :nth-child(3)', visible: :all).click # "Assigned To"
            find('div.menu-option-wrapper__list > :nth-child(8)').click
            find('ss-ui-row.row > :nth-child(2)').click # yes
        find('[aria-label="Priority"] > :nth-child(3)', visible: :all).click # "Priority"
            find('div.menu-option-wrapper__list > :nth-child(8)').click
            find('ss-ui-row.row > :nth-child(2)').click # yes
        find('[aria-label="Due Date"] > :nth-child(3)', visible: :all).click # "Due Date"
            find('div.menu-option-wrapper__list > :nth-child(8)').click
            find('ss-ui-row.row > :nth-child(2)').click # yes
            sleep(1)
        find('[aria-label="Status"] > :nth-child(3)', visible: :all).click # "Status"
            find('div.menu-option-wrapper__list > :nth-child(8)').click
            find('ss-ui-row.row > :nth-child(2)').click # yes

        find('div.application-navbar-item__link[aria-label="SS UI table"]').click
            sleep(1)
        find('[value]').click.set("Table 1").send_keys(:enter)

        sleep(5)
        


    end # it 4 | setup solution - tables and fields

end # respec


# "div.r-solution-preview-panel__solutions-inner:nth-child(0):nth-child(0)"
# article.solution-preview-card:nth-child(1) > div:nth-child(1)
# divr-solution-preview-panel__solutions-outer:nth-child(1) > div:nth-child(1) > article:nth-child(2) > div:nth-child(1)

