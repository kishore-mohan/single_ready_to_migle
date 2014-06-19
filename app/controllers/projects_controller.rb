class ProjectsController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_filter :ensure_login, :only => [:index]
  #before_filter :ensure_logout, :only => [:new, :create]


  def index
  	@projects = LetsMingle.new(@user.email_id,@user.password).get_projects
  end

  def set_project_name
  	@is_admin = true
    @project = Project.where(:mingle_name => params["project"]["name"]).first_or_create    
    @db_cards = Card.where(:project_id=> @project.id)   
    render 'list_cards'
  end

  def pull_cards
 	@cards = LetsMingle.new(@user.email_id, @user.password, params["project_name"] ).get_cards
    project = Project.where(:mingle_name => params["project_name"]).first_or_create 
    unless @cards.blank?
      @cards.each do|a|
        card = Card.new
        card.number = a[:number]
        card.url = a[:name]
        card.description = a[:description]
        card.card_type = a[:type]
        card.mingle_id = a[:id]
        card.user_id = @user.id
        card.project_id = project.id
        card.save
      end
    @db_cards = Card.where(:project_id=> project.id)
    end  
    respond_to(:js) 
  end

  def list_cards
  end
end
