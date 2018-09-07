class RepositoriesController < ApplicationController
  def index
    repos = GithubRepo.new
    @repos = repos.get_repos(session[:token])
  end

  def create
    repos = GithubRepo.new
    repos.create_repo(params[:name], session[:token])
    redirect_to '/'
  end
end
