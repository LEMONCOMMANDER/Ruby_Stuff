require 'capybara/rspec'
require 'selenium-webdriver'

=begin NOTES
TAGS... If you are not using Rails, tag all the example groups in which you want to use Capybara with type: :feature.

Seelectors - Capybara uses CSS Selectors by default. otherwise || find(:xpath, './/ul/li').text ||
    this can work the same with using class name or id -- https://www.rubydoc.info/github/teamcapybara/capybara/Capybara/Selector
        page.find :id, 'content'

Drivers - RackTest is for pure Ruby based code and can't interperate anything else like JS
    You can sepcify alternatives like Sleneium as seen below

Accessing Selenium: We used || page.driver.browser || to directly interact with the Selenium WebDriver, 
    which gives you access to all Selenium-specific methods:
            # Let’s assume we need to scroll to an element that Capybara can't scroll to
            # Direct access to Selenium driver to scroll to a specific element
            element = page.driver.browser.find_element(:css, "footer")

            # Scroll using Selenium's JavaScript execution
            page.driver.browser.execute_script("arguments[0].scrollIntoView();", element)

=end

# ------------------- variables
## setup

# driver = Selenium::WebDriver.for :chrome # <= selenium docs || capybara docs => driver = :selenium_chrome => Selenium driving Chrome
Capybara.default_driver = :selenium_chrome


RSpec.describe "going to google", type: :feature do
    it "goes to google and confirms that the search bar is there, and checks the webpage" do
        visit 'https://www.google.com/'
        find(:css, '#APjFqb')
        expect(page).to  have_current_path('https://www.google.com/')
    end
end




