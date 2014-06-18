class ProjectsController < ApplicationController
  before_filter :ensure_login, :only => [:index]
  #before_filter :ensure_logout, :only => [:new, :create]


  def index
  end

  def new

  end
end
