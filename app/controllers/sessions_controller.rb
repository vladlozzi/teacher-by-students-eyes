class SessionsController < ApplicationController
  def create
    if request.env['omniauth.auth'].present?
      authorized_email = request.env['omniauth.auth'][:info][:email]
      if authorized_email == Rails.application.credentials.editor_email
        session[:editor] = true
      end
    end
    redirect_to root_path
  end

  def destroy
    session.delete :editor
    redirect_to root_path
  end

  def omniauth

  end
end