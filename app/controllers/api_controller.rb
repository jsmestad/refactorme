class ApiController < ApplicationController
  def github_commit
    @payload = JSON.parse(params[:payload])
    @payload["commits"].each do |commit|
      if @user = User.find_by_github_username(commit["author"]["name"])
        # .. use this commit ..
        # grab affected files
        # create snippet as user
      end
    end
    
    render :text => "thanks."
  end
end
