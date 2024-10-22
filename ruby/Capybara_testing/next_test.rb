require 'capybara/dsl'
require 'rspec'
require_relative 'login_info'
require_relative 't_metrics'

Capybara.default_driver = :selenium_chrome
Capybara.default_max_wait_time = 8

############################################ SETUP ############################################################################
################################################# SETUP #######################################################################
###################################################### SETUP ##################################################################

@creds = Login.new
metrics = Metrics.new
# @ttime = nil
message = nil

RSpec.shared_context "shared" do 
    before(:each) do
        metrics.start()
    end
    after(:each) do
        if message == nil
            message = "--"
        end
        metrics.report(@ttime, @message)
    end
end


RSpec.describe "account creation practice" do
    include Capybara::DSL
    it "|| presonus attempt" do 
        visit('https://www.presonus.com/en-US/start')
        @ttime = Time.now
        page.driver.browser.manage.window.maximize
        #################################################
        sleep(10)
        # #########################################################################################################
        #     "GPT FOR TEST"
        #     # Find the button using data-testid or id

        #     # toggle_button = find('button#toggle-toggle-ccpa-banner')
        #     toggle_button = find('button.sc-leSDtu.hIcmFD')
        #     #toggle-toggle-ccpa-banner

        #     # Check the aria-checked attribute
        #     if toggle_button[:'aria-checked'] == "false"
        #         # If aria-checked is "false", click the button to toggle it
        #         toggle_button.click
        #         puts "Toggled the switch to NOT sell data."
        #     else
        #         # If aria-checked is "true", no action is needed
        #         puts "The toggle is already set to NOT sell data."
        #     end
        #     sleep(2)
        # #########################################################################################################
        # find('.sc-dcJsrY').click
        #     sleep(2)
        #########################################################################################################
        find('.c-site-header__top__utility--item > div:nth-child(1) > a:nth-child(1)').click
            sleep(2)
        find('label.option:nth-child(2)').click
            sleep(2)
        # find('input.login-input.ng-pristine.ng-valid.ng-touched').set("joe")
        page.fill_in("First Name",	with: "joe") 
            sleep(2)
        find('input.login-input:nth-child(2)').set('test')
            sleep(2)
        find('div.single-input:nth-child(3) > input:nth-child(1)').set('jibjif1@gmail.com')
            sleep(2)
        find('.password-input > input:nth-child(1)').set("Autotest1!")
            sleep(2)
        # find('#recaptcha-anchor').click
        page.check('span#recaptcha-anchor')
            sleep(10)
    end
end
