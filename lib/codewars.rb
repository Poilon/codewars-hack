require_relative '../config/boot'
require 'timeout'

class Codewars

  def self.hack
    I18n.config.available_locales = :en
    browser = Watir::Browser.new(:chrome)
    browser.goto('https://www.linkedin.com/')
    browser.text_field(id: 'login-email').set('jean.ivan6969@gmail.com')
    browser.text_field(id: 'login-password').set('jeanivan2')
    browser.button(id: 'login-submit').click
    res = ''

    {
      'https://www.linkedin.com/edu/alumni?id=12501' => 'upem',
      'https://www.linkedin.com/edu/alumni?id=162147' => 'parisest',
      'https://www.linkedin.com/edu/alumni?id=12350' => 'enpc',
      'https://www.linkedin.com/edu/alumni?id=20041' => 'esiee',
      'https://www.linkedin.com/edu/alumni?id=12351' => 'ensg',
      'https://www.linkedin.com/edu/alumni?id=21233' => 'eavt'
    }.each do |k, v|
      browser.goto(k)
      browser.text_field(id: 'alumni-search-start-year').set('2009')
      150.times do
        browser.as(class: 'image')[-2].scroll.to
        sleep(1)
      end
      res += (I18n.transliterate(browser.divs(class: 'profile-info').map(&:text).map do |e|
        first_name = e.split("\n")&.first&.downcase&.split(' ')&.first
        last_name = e.split("\n")&.first&.downcase&.split(' ')[1..-1]&.join
        send(v, first_name, last_name)
      end.join(', '))) + ' '
    end
    puts res
  end



  def self.upem(first_name, last_name)
    "#{first_name}.#{last_name}@u-pem.fr"
  end

  def self.parisest(first_name, last_name)
    "#{first_name}.#{last_name}@univ-paris-est.fr"
  end

  def self.enpc(first_name, last_name)
    "#{first_name}.#{last_name}@enpc.fr"
  end

  def self.esiee(first_name, last_name)
    "#{first_name}.#{last_name}@esiee.fr"
  end

  def self.ensg(first_name, last_name)
    "#{first_name}.#{last_name}@ensg.eu"
  end

  def self.eavt(first_name, last_name)
    "#{first_name}.#{last_name}@marnelavallee.archi.fr"
  end
end
