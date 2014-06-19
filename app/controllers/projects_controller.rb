class ProjectsController < ApplicationController
  before_filter :ensure_login, :only => [:index]
  #before_filter :ensure_logout, :only => [:new, :create]


  def index
  	@projects = LetsMingle.new(@user.email_id,@user.password).get_projects
  end

  def set_project_name
    @cards = LetsMingle.new(@user.email_id, @user.password, params["project"]["name"] ).get_cards
    render 'list_cards'
  end

  def list_cards

  end
end
