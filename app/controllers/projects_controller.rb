class ProjectsController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_filter :ensure_login

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

  def send_email
    #todo need to send th users
    #@users = LetsMingle.new(@user.email_id, @user.password, params["project"]["name"] ).get_users
    comment = params[:email_notify]["comment"]
    url     = params[:email_notify]["url"]
    MingleMailer.welcome_email(comment,url)
    flash[:notice] = "Email Notification Sent"
    redirect_to list_cards_projects_path
  end

  def show_card
    @show_card = Card.find(params[:id])
  end

  def update
    @card = Card.find(params[:id])
    if @card.update_attributes(params[:card])
      flash[:notice] = "Card updated Successfully"
      redirect_to project_path(:number => @card.number)
    else
      flash[:notice] = "Some Problem is there. Please review the details"
       redirect_to show_card_projects_path
    end
  end

  def show
     @cards = Card.where(params[:number])
    raise @cards.inspect
  end
end
