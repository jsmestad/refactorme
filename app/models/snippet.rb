require 'nokogiri'
require 'open-uri'

class Snippet < ActiveRecord::Base
  acts_as_list
  
  belongs_to :user
  has_many :refactors
  
  validates_presence_of :title, :message => "can't be blank"
  validates_presence_of :code, :message => "can't be blank"

  def self.set_daily_snippet
    todays = Snippet.first(:conditions => 'displayed_on IS NULL AND position IS NOT NULL', :order => 'position')
    if todays.remove_from_list
      todays.update_attribute :displayed_on, Date.today
    else
      Exception.new("Error running rake set_todays_snippet at #{Time.now}, remove_from_list returned false.")
    end
  end
  
  def approve!
    add_to_list
  end
  
  def reject!
    return self.destroy ? true : false
  end
  
  def gist_url
    "http://gist.github.com/#{self.gist_id}"
  end
  
  def gist_url=(url)
    self.gist_id = url.match(/\/(\d+)\/?/)[1]
    gist_url = "http://gist.github.com/#{gist_id}"
    doc = Nokogiri::HTML.parse(open(gist_url))
    
    raw_gist_url = "http://gist.github.com" + doc.xpath('//a[text()="raw"]').first.attributes['href'].to_s

    self.code = open(raw_gist_url).read
  end
  
  def code=(code)
    write_attribute(:code, code) unless code.blank?
  end
  
end
