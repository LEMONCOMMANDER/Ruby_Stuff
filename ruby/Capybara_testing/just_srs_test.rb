require 'capybara/dsl'
require 'rspec'
require 'selenium-webdriver'

Capybara.default_driver = :selenium_chrome
    Capybara.default_max_wait_time = 10

class Srs
    include Capybara::DSL

    def to_srs()
        visit("https://www.srsacquiom.com/")
        # sleep(3) 
    end

    def clear_cookie()
        click_item = find('#onetrust-accept-btn-handler')
        click_item.click
        sleep(2)
    end

    def check_mobile()
        begin
            click_item = find('#nav-toggle', wait: 2)
            click_item.click
            sleep(3)
        rescue => e
            puts "error is "
            puts e
        end 
        begin 
            click_item = find('a.second-level-link:nth-child(1)')
        rescue => e
            puts "error is "
            puts e 
        end
    end

end

search = Srs.new
search.to_srs()
search.clear_cookie()
search.check_mobile()