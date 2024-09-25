#using chat gpt to learn capybara /  selnieum interactions and rsepc

require 'capybara/rspec'

# Set Capybara to use Selenium with Chrome
Capybara.default_driver = :selenium_chrome

RSpec.describe "Google Visit", type: :feature do
  it "visits Google homepage" do
    visit "https://www.google.com"
    expect(page).to have_content("Google")  # Checks that "Google" appears on the page
  end
end
