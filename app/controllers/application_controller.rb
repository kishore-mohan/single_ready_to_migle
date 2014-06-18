class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :maintain_session_and_user

  def ensure_login
    unless @user
      flash[:notice] = "Please login to continue"
      redirect_to(new_session_path)
    end
  end

  def ensure_logout
    if @user
      flash[:notice] = "You must logout before you can login or register"
      redirect_to(root_url)
    end
  end

  private

  def maintain_session_and_user
    if session[:id]
      if @application_session = Session.find_by_id(session[:id])
        @user = @application_session.user
      else
        session[:id] = nil
        redirect_to(root_url)
      end
    end
  end
end
