class ProjectsController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_filter :ensure_login, :only => [:index]
  #before_filter :ensure_logout, :only => [:new, :create]


  def index
  	@projects = LetsMingle.new(@user.email_id,@user.password).get_projects
  end

  def set_project_name
    @cards = LetsMingle.new(@user.email_id, @user.password, params["project"]["name"] ).get_cards

    unless @cards.blank?
      @cards.each do|a|
        card = Card.new
        card.number = a[:number]
        card.url = a[:name]
        card.description = a[:description]
        card.card_type = a[:type]
        card.mingle_id = a[:id]
        card.user_id = @user.id
        card.save
      end
    end
    redirect_to list_cards_projects_path
  end

  def list_cards
    @db_cards = Card.all
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
       raise params.inspect
  end
end
