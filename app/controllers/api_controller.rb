class ApiController < ApplicationController

  def github_commit
    @payload = JSON.parse(params[:payload])
    @payload["commits"].each do |commit|
      if @user = User.find(:first, :conditions => ['login = ? OR email = ? OR github_username = ?', commit["author"]["name"], commit["author"]["email"], commit["author"]["name"]] )
        process_commit(commit)
        # .. use this commit ..
        # grab affected files
        # create snippet as user
      end
    end
    render :text => 'thing.'
  end

protected

  def process_commit(commit)
    require 'rest_client'
    @result = commit["url"].match(/http:\/\/\w+\.com\/(\w+)\/(\w+)\/commit\/(.+)/i)
    diff = JSON.parse(RestClient.get("http://github.com/api/v2/json/commits/show/#{@result[1]}/#{@result[2]}/#{@result[3]}"))
    diff["commit"]["modified"].each do |mod|
      @raw_file = RestClient.get "#{commit["url"]}/#{mod["filename"]}"
      url = URI.parse('http://gist.github.com/gists')
      req = Net::HTTP.post_form(url, { 'file_ext[gistfile1]' => 'rb', 'file_ext[gistfile1]' => "#{mod["filename"]}", 'file_contents[gistfile1]' => @raw_file })
      Snippet.send_later(:create, { :context => commit["message"],
                                  :gist_url => req['Location'],
                                  :title => "Posted from #{commit["url"]}"})
    end
  end

end
