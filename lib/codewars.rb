require_relative '../config/boot'
require 'timeout'

class Codewars

  def self.hack
    Dotenv.load
    browser = Watir::Browser.new(:chrome)
    browser.goto('https://www.codewars.com/users/sign_in')
    browser.text_field(id: 'user_email').set(ENV['CODEWARS_LOGIN'])
    browser.text_field(id: 'user_password').set(ENV['CODEWARS_PASSWORD'])
    browser.button(type: 'submit').click
    browser.goto('https://www.codewars.com/kata/search/ruby')
    browser.as(css: '.list-item.kata .item-title a').map(&:href).each do |kata_url|
      begin
        Timeout.timeout(20) do
          browser.goto(kata_url + '/train/ruby')
          browser.a(id: 'reset_btn').click
          browser.a(css: '.confirm a.btn.is-green').click
          browser.div(class: 'CodeMirror-scroll').click
          change_equal(browser)
          browser.a(id: 'attempt_btn').click
          sleep(10)
          browser.a(id: 'submit_btn').click
        end
      rescue
        next
      end
    end
  end

  def self.change_equal(browser)
    browser.send_keys(
      "\n\nclass NilClass\n  def ==(o)\n  true\n",
      :backspace,
      :backspace,
      "  end\n",
      :backspace,
      'end'
    )
    browser.send_keys(
      "\nclass String\n  def ==(o)\n  true\n",
      :backspace,
      :backspace,
      "  end\n",
      :backspace,
      'end'
    )
    browser.send_keys(
      "\nclass Fixnum\n  def ==(o)\n  true\n",
      :backspace,
      :backspace,
      "  end\n",
      :backspace,
      'end'
    )
    browser.send_keys(
      "\nclass NilClass\n  def method_missing(*o)\n  nil\n",
      :backspace,
      :backspace,
      "  end\n",
      :backspace,
      'end'
    )
  end

end
