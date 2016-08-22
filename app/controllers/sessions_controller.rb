class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    github             = GithubService.new
    session[:token]    = github.authenticate!(ENV["GITHUB_CLIENT"], ENV["GITHUB_SECRET"], params[:code])
    
    access_hash        = {"access_token" => session[:token] }
    git_request        = GithubService.new(access_hash)

    session[:username] = git_request.get_username

    redirect_to '/'
  end
end