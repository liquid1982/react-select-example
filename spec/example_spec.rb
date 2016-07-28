require 'capybara'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'selenium-webdriver'
require 'site_prism'

class ReactSelectElement < SitePrism::Section
  element :input_element, '.Select-input input'
  elements :options, '.Select-option'

  def select_option(text)
    root_element.click
    input_element.send_keys text
    options.first.click
  end
end

class ReactSelectPage < SitePrism::Page
  set_url 'http://jedwatson.github.io/react-select/'
  section :states_select, ReactSelectElement, '#example > div > div:nth-child(1) > .Select'
end

describe 'interacting with react-select component' do
  let(:page) { ReactSelectPage.new.tap(&:load) }

  it 'works using Selenium' do
    Capybara.configure { |c| c.default_driver = :selenium }

    page.states_select.select_option 'Victoria'
    expect(page.states_select).to have_text 'Victoria'
  end

  it 'works using Poltergeist' do
    Capybara.configure { |c| c.default_driver = :poltergeist }

    page.states_select.select_option 'Victoria'
    expect(page.states_select).to have_text 'Victoria'
  end
end
