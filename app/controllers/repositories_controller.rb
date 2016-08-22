class RepositoriesController < ApplicationController
  before_action :set_service

  def index
    @repos_array       = @request.get_repos
    session[:username] = @request.get_username
  end

  def create
    response    = @request.create_repo(params[:name])
    redirect_to '/'
  end

  private

  def set_service
    access_hash = {}
    access_hash["access_token"] = session[:token]
    @request    = GithubService.new(access_hash)
  end
end
