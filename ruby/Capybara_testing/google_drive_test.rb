require 'capybara/dsl'
require 'rspec'

require_relative "login_info"

Capybara.default_driver = :selenium_chrome
Capybara.default_max_wait_time = 10
############################################################################

RSpec.shared_context "test setup" do
    # after(:all) do
    #     capybara.reset_sessions!
    # end

    before(:each) do
    end

    after(:each) do
    end
end

########### TEST START ##########################################################################################################
####################### TEST START ##############################################################################################
################################### TEST START ##################################################################################

# RSpec.describe "login to google drive" do 
#     include Capybara::DSL
#     # login credentials 
#     before(:all) do
#         @creds = Login.new
#         @un = @creds.get_cred(:google_drive)[0]
#         @pw = @creds.get_cred(:google_drive)[1] 
#     end
#     # clear them for safety 
#     after(:all) do 
#         @un = ''
#         @pw = ''
#     end
#     it "gets login info and logs into google drive" do

#         # go to google drive 
#         Capybara.reset_sessions!
#         visit('https://accounts.google.com/v3/signin/identifier?continue=https%3A%2F%2Fdrive.google.com%2Fdrive%2Fmy-drive&followup=https%3A%2F%2Fdrive.google.com%2Fdrive%2Fmy-drive&ifkv=ARpgrqemqDrm-a3jDR0OAaWAibIekkX0c-Rh0iyEcmR76ii_bVhbngJ40wtHYQUm6PP4RGKOZflZrw&osid=1&passive=1209600&service=wise&flowName=GlifWebSignIn&flowEntry=ServiceLogin&dsh=S-502478080%3A1727812962332073&ddm=0')
#         sleep (1)
        
#         # find('input#identifierId').set(@un).send_keys(:enter)
#         find('input.whsOnd.zHQkBf[type="email"]').set(@un).send_keys(:enter)
#         input = find('input.whsOnd.zHQkBf[type="password"]')
#         input.send_keys(@pw)
#         sleep(5)
#         input.send_keys(:enter)
#         sleep (10)
#     end
# end

RSpec.describe "force of nature test" do
    include Capybara::DSL
    before(:all) do
        creds = Login.new
        @un = creds.get_cred(:forceofnature)[0]
        @pw = creds.get_cred(:forceofnature)[1]
    end

    it "logs into force of nature" do
        visit('https://forceofnature.com/')
        find('a.header__icon.header__icon--account.link.focus-inset.small-hide').click 
        expect(current_url).to eq('https://forceofnature.com/account/login')

        find('input#CustomerEmail').set(@un)
        find('input#CustomerPassword').set(@pw)
        find('button.button--primary').click

        find('div.hero-banner__text-overlay', wait: 70)
        expect(find('[aria-label="Order number #74869"]').text).to eq('#74869')

        find('summary#HeaderMenu-shop-now').click
        sleep(10)

    end

end