class SessionsController < ApplicationController
  def new
    redirect_to "auth/google"
  end

  def create
    if ApiConsumer.exists?(email)
      session[:user_id] = email
      redirect_to sessions_current_path
    else
      ApiConsumer.create_from_omniauth(auth_hash)
      session[:authenticated_email] = email
      session[:user_id] = email
      redirect_to sessions_current_path
    end
  end

  def destroy
    session[:user_id] = nil

    head :no_content
  end

  def current
    if session[:user_id].present?
      render json: { email: session[:user_id] }
    else
      head :unauthorized
    end
  end

  private

  def name
    auth_hash[:info][:name]
  end

  def email
    auth_hash[:info][:email] || auth_hash[:info][:emails].first[:value]
  end

  def auth_hash
    request.env['omniauth.auth'].with_indifferent_access
  end
end
