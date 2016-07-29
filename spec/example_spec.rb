require 'capybara'
require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'capybara/poltergeist'
require 'selenium-webdriver'
require 'site_prism'

class ReactSelectElement < SitePrism::Section
  element :input_element, '.Select-input input'
  elements :options, '.Select-option'

  def set(text)
    root_element.click

    if Capybara.current_driver == :poltergeist
      root_element.send_keys text
      root_element.send_keys :enter
    else
      input_element.set text
      input_element.send_keys :enter
    end
  end
end

class ReactSelectPage < SitePrism::Page
  set_url 'http://jedwatson.github.io/react-select/'
  section :states_select, ReactSelectElement, '#example > div > div:nth-child(1) > .Select'
end

describe 'react-select component' do
  let(:page) { ReactSelectPage.new.tap(&:load) }

  it 'can be interacted with using Selenium' do
    Capybara.default_driver = Capybara.javascript_driver = :selenium

    page.states_select.set 'Victoria'
    expect(page.states_select).to have_text 'Victoria'
  end

  it 'can be interacted with using Poltergeist' do
    Capybara.default_driver = Capybara.javascript_driver = :poltergeist

    page.states_select.set 'Victoria'
    expect(page.states_select).to have_text 'Victoria'
  end
end
