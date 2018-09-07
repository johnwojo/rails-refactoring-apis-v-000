class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    new_session = GithubRepo.new
    session[:token] = new_session.authenticate!(ENV['GITHUB_CLIENT'], ENV['GITHUB_SECRET'], params[:code])
    session[:username] = new_session.get_username(session[:token])
    redirect_to '/'
  end
end
