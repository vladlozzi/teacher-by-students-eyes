class SessionsController < ApplicationController
  def omniauth
    @session_email = request.env['omniauth.auth'][:info][:email]
  end
end