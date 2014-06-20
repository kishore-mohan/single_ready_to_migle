class ProjectsController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_filter :ensure_login

  def index
  	@projects = LetsMingle.new(@user.email_id,@user.password).get_projects
  end

  def set_project_name
    @project = Project.where(:mingle_name => params["project"]["name"]).first_or_create    
    @db_cards = Card.where(:project_id=> @project.id)  
    LetsMingle.new(@user.email_id, @user.password, params["project"]["name"] ).update_user
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
    show_all_cards
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

  def show_user_estimation
  	project = Project.where(:mingle_name => params["project_name"]).first_or_create
  	cards = project.cards.where("estimation is null")
  	@est = EstimationDetail.where(:card_id=>cards.pluck(:id))
  	@uniq_card = @est.pluck(:card_id).uniq
  	respond_to(:js)
  end

  def update
    @card = Card.find(params[:id])
    estimation_detail = EstimationDetail.find_by_card_id_and_user_id(@card.id,@user.id)
    unless estimation_detail.blank?
      if estimation_detail.update_attributes(:estimate => params[:card][:estimate],:comments => params[:comments])
        flash[:notice] = "Estimation updated Successfully"
        redirect_to list_cards_projects_path(:id=>params[:id],:project=>{:name => @card.project.mingle_name})
      else
        flash[:notice] = "Some Problem is there. Please review the details"
        redirect_to show_card_projects_path
      end
    else
      estimation_detail          = EstimationDetail.new
      estimation_detail.user_id  = @user.id
      estimation_detail.estimate = params[:card][:estimate]
      estimation_detail.card_id  = @card.id
      estimation_detail.number   = @card.number
      estimation_detail.comments = params[:comments]
      estimation_detail.save
      if estimation_detail.save
        flash[:notice] = "Estimation updated Successfully"
        redirect_to list_cards_projects_path(:id=>params[:id],:project=>{:name => @card.project.mingle_name})
      else
        flash[:notice] = "Some Problem is there. Please review the details"
        redirect_to show_card_projects_path
      end
    end

  end

  def show
     @cards = EstimationDetail.where(params[:number])
    #raise @cards.inspect
  end
  
  def destroy_card
    @card = Card.find(params[:id])
    @card.destroy
    respond_to(:js) 
  end

  def show_all_cards
     card = Card.find(params[:id])
     @project = card.project
    @db_cards = Card.where(:project_id=> @project.id)
  end
end
