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
            @ttime = Time.now
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
                # find('div.view-list-item.view-mode-grid.is-selected') # lets the page load 
                expect(page).to have_selector('div.view-list-item.view-mode-grid.is-selected') # @@@@ T5 | "grid view"
                    # lets the page load before checking the url
                expect(page.current_url).to include("https://app.smartsuite.com/sr7y4774/solution/6712d0d71bc87a93047c497e")
                # part of the solution url  || @@@@@ T5 | check proper solution 
        end 
    end # it 3 | navigates to or creates solution

    it "creates a new table in the solution, deletes the old one, and clears all fields" do # 4
        @ttime = Time.now
        @current_url = current_url
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
            sleep(1) # needs delay for application side
        find('[aria-label="Status"] > :nth-child(3)', visible: :all).click # "Status"
            find('div.menu-option-wrapper__list > :nth-child(8)').click
            find('ss-ui-row.row > :nth-child(2)').click # yes

        find('div.application-navbar-item__link[aria-label="SS UI table"]').click
            sleep(1)
        find('[value]').click.set("Table 1").send_keys(:enter)
        find('div.application-navbar-item__link[aria-label="Table 1"]').click

            time1 = Time.now
        # checks that fields are deleted || @@@@@ T6-9 | deleted fields 
        expect(page).not_to have_selector('[aria-label="Assigned To"] > :nth-child(3)', wait: 2) # assigned to
        expect(page).not_to have_selector('[aria-label="Priority"] > :nth-child(3)', wait: 2) # priority
        expect(page).not_to have_selector('[aria-label="Due Date"] > :nth-child(3)', wait: 2) # due date
        expect(page).not_to have_selector('[aria-label="Status"] > :nth-child(3)', wait: 2) # status
            time2 = Time.now
            @message = "checks on deleted fields took: #{(time2 - time1).round(3)} seconds"
    end # it 4 | setup solution - tables and fields

    it "adds a 'text' field to the grid view" do # 5
            @current_url = current_url
            @message = "adds text field"
        find('svg.icon.icon--transition[aria-label="Grid add column icon"]').click
        find('button.field-type-option[aria-label="Text"]').click
        find('input[aria-label="Field label"]').set("UI text")
        find('button.button.field-form__update[role="button"]').click

            expect(page).to have_selector('div[aria-label="UI text"]') # @@@@@ T10 | new text field 
    end # it 5 | adds a text field 

    it "adds a 'number' field to the grid view" do # 6
            @current_url = current_url
            @message = "adds number field"
            sleep(1)
        find('svg.icon.icon--transition[aria-label="Grid add column icon"]').click
        find('button.field-type-option[aria-label="Number"]').click
        find('input[aria-label="Field label"]').set("UI number")
        find('button.button.field-form__update[role="button"]').click

            expect(page).to have_selector('div[aria-label="UI number"]') # @@@@@ T11 | new number field 
    end # it 6 | adds a number field 

    it "adds a 'link' field to the grid view" do # 7
            @current_url = current_url
            @message = "adds link field"
            sleep(1)
        find('svg.icon.icon--transition[aria-label="Grid add column icon"]').click
        find('button.field-type-option[aria-label="Link"]').click
        find('input[aria-label="Field label"]').set("UI link")
        find('button.button.field-form__update[role="button"]').click

            expect(page).to have_selector('div[aria-label="UI link"]') # @@@@@ T12 | new link field 
    end # it 7 | adds a link field 

    it "creates a new record titled 'UI test record'" do # 8
            @current_url = current_url
            @message = "adds a new record"
        find('svg[aria-label="Grid add row icon"]').click
        find('input[aria-label="Title field grid cell input"]').set("UI test record").send_keys(:enter)
    end # it 8 | createws a new record

    it "opens the record and adds some information in the added fields" do
        find('span[aria-label="Expand Row"]').click
            @ttime = Time.now
            @current_url =  current_url

            expect(page).to have_selector('div.editor.smartdoc-field-editor__editor.smartdoc-field-editor--visible')
                # @@@@ T13 | make sure the description default field is present - if so record open
            expect(page).to have_selector('[aria-label="Write here"]')
                # @@@@ T14 | detect presence of 'UI text' added
            expect(page).to have_selector('[aria-label="Number Field Input"]')
                # @@@@ T15 | detect presence of 'UI number' added
            expect(page).to have_selector('[aria-label="Enter web address"]')
                # @@@@ T15 | detect presence of 'UI link' added

        find('[aria-label="Write here"]').click.set("SS UI TEST  || Time.now stamp in seconds >>")
            find('div.editor.smartdoc-field-editor__editor.smartdoc-field-editor--visible').click
        find('[aria-label="Number Field Input"]').click.set(13)
            find('div.editor.smartdoc-field-editor__editor.smartdoc-field-editor--visible').click  
        find('[aria-label="Enter web address"]').click.set((current_url).to_s)
            find('div.editor.smartdoc-field-editor__editor.smartdoc-field-editor--visible').click   
        
        find('button[aria-label="Save"]').click   

        ## confirms proper info
        sleep(3)
        expect(find('p[aria-label="UI text field grid cell content"]').text).to eq("SS UI TEST || Time.now stamp in seconds >>")
            # @@@@ T16 | checks UI text value
        expect(find('p[aria-label="Number Field Grid Control Value"]').text).to eq("13")
            # @@@@ T17 | checks the value of UI number (13)
        expect(find('span.link-field-content.link-field-content--link_only.link-list-item__content.is-clickable').text).to eq((@current_url))
            # @@@@ T18 | checks the value of UI link 
    end # it 9 | opens record and adds info

    it "activates the spotlight feature" do
        find('button[aria-label="Report Toolbar Button Spotlight"]').click
        find('button[aria-label="Conditions"]').click
        find('input[aria-label="Enter text here..."]').click.set('UI test record')
        find('button[aria-label="Report Toolbar Button Spotlight"]').click
        
            expect(page).to have_selector('span.grid-view-row__spotlight.grid-view-row__dragging-opacity[style="background-color: rgb(58, 134, 255);"]')
            # @@@@ T19 | makes sure the spotlight feature correctly highlights the record         
            sleep(3)
    end
end # rspec