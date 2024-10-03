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
ttime = nil
message = nil

RSpec.shared_context "shared" do 
    before(:each) do
        metrics.start()
    end
    after(:each) do
        if message == nil
            message = "--"
        end
        metrics.report(ttime, @message)
    end
end

RSpec.describe "test1" do
    include_context "shared"
    it "does something 1" do 
        ttime = Time.now
        expect(5).to eq(5)
    end

    it "does something 2" do 
        ttime = Time.now
        expect(5).not_to eq(7)
    end
end

