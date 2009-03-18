class Refactor < ActiveRecord::Base
  belongs_to :snippet
  belongs_to :user
  has_many :votes
  
  validates_presence_of :code, :if => :gist_is_blank?
  
  before_save :send_to_gist
  
  def code=(code)
    write_attribute(:code, code) unless code.blank?
  end
  
  def gist_url
    "http://gist.github.com/#{self.gist_id}"
  end
  
  def gist_url=(url)
    id = url.match(/[http:\/\/gist.github.com\/]?(\d+)\/?/)
    unless id.nil?
      p id[1]
      self.gist_id = id[1]
      gist_url = "http://gist.github.com/#{gist_id}"
      doc = Nokogiri::HTML.parse(open(gist_url))
      raw_gist_url = "http://gist.github.com" + doc.xpath('//a[text()="raw"]').first.attributes['href'].to_s
      self.code = open(raw_gist_url).read
    end
  end
  
  def send_to_gist
    if self.gist_id.blank?
      response = Net::HTTP.post_form(URI.parse('http://gist.github.com/api/v1/xml/new'), { "files[refactorme_#{self.created_at.strftime('%b%d%y').downcase!}_#{self.id}.rb]" => "#{self.code}" })
      doc = Nokogiri::XML.parse(response.body)
      repo_id = doc.xpath('//repo').first.content
      write_attribute(:gist_id, repo_id)
    end
  end
  
  def display
    result = open(gist_url + ".js").read
    result.scan(/document.write\('(.*|\s*)'\)/)[1][0]
  end
  
  private
  
    def gist_is_blank?
      self.gist_id.blank?
    end
end