class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def set_editor
    unless session[:user] == "editor"
      redirect_to auth_google_oauth2_path
    end
  end

end
