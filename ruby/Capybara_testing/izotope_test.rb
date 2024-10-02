require 'capybara/dsl'
require 'rspec'

require_relative "login_info"
# requires you to add your own info to the template file and rename.... 

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

RSpec.describe "izotope test" do
    include Capybara::DSL
    before(:all) do
        creds = Login.new
        @un = creds.get_cred(:izotope)[0]
        @pw = creds.get_cred(:izotope)[1]
    end
    after(:all) do # protects credentials after login
        @un = ""
        @pw = ""
    end

    it "goes to iztope and logs in" do
        visit('https://www.izotope.com/en')
        page.driver.browser.manage.window.maximize
############# assert 1 ##############
        expect(current_url).to eq('https://www.izotope.com/en') # using the english version
        expect(page).to have_selector('#\38 518619')
        expect(find('div.place-content-center:nth-child(1) > div:nth-child(1) > div:nth-child(1) > h2:nth-child(1)').text).to eq("Shop our most popular products")
        # 'div.place-content-center:nth-child(1) > div:nth-child(1) > div:nth-child(1) > h2:nth-child(1)'
#####################################
#'h2[style="text-align:center;"]'
#'h2[style="text-align:center;"]'

        find('.px-1\.5').click
        find('a.webex-btn.webex-btn--primary.webex-btn--sm.w-full').click
        ## enter creds
        find('#\31 -email').set(@un)
        sleep(2)
        find('#\31 -password').set(@pw)
        sleep(2)
        find('#\31 -submit').click
    end
end

RSpec.describe "continues test after login" do
    include Capybara::DSL
    it "confirms login" do
        # puts "un is: #{@un}"
        # puts "pw is: #{@pw}"
        #######################
        find('.px-1\.5').click
            # confirm correct account 
            expect(find('div.text-sm.text-grey-60.mb-2').text).to eq('josephetroop@gmail.com')
            sleep(1)
        # click on cart
        find('a.px-1.h-4').click
            # check cart is empty
            expect(find('h5.mb-4.webex-h5.text-grey-60').text).to eq('Shopping cart is empty.')
        # continue shopping 
        find('a.webex-btn').click 
            expect(current_url).to eq('https://www.izotope.com/en/catalog/')
    end

    it "adds some stuff to cart" do 
        find('input#checkbox-best-sellers',visible: true).check
        #page.check('div.mt-4:nth-child(2) > div:nth-child(2) > ul:nth-child(2) > li:nth-child(1) > div:nth-child(1) > input:nth-child(1)')
        # select 'RX Elements'
        sleep(2)
        find('div.color-initial:nth-child(8) > div:nth-child(1) > div:nth-child(1) > a:nth-child(1)').click
    # add to cart
        # find('button.webex-btn.webex-btn--primary').click
        sleep(2)
        # click_button('Add to cart')
        find('div.self-start:nth-child(3) > div:nth-child(1) > button:nth-child(5)').click
        sleep(1)
        # click_button("Continue Shopping")
        find('a.webex-btn').click
        #click on cart
        find('a.px-1.h-4').click
            #c check total
            expect(find('span[data-testid="cart-totals-grand-total"]').text).to eq('$99.00')
        # remove from cart 
        click_button("Remove")
        sleep(2)
    end
end



=begin
#\31 -submit -- id="1-submit"
Here's a breakdown of what's happening:

    CSS identifier rules: In CSS, identifiers like class names or IDs cannot start with a digit unless they're escaped. 
    For example, if the HTML element has an id="1-submit", you can't directly select it using #1-submit in CSS because 
    it violates the CSS syntax rules.

Escaping the number: To work around this, CSS allows you to "escape" the leading number by using a backslash (\). The specific case you see, #\31 -submit, is the escaped form of an ID that likely looks like id="1-submit".

    \31 represents the Unicode character for the number 1 (which is U+0031 in Unicode).
    So, #\31 -submit is the correct CSS way of selecting an element with id="1-subm

=end

