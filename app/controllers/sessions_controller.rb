class SessionsController < ApplicationController
  def new
    redirect_to "auth/google"
  end

  def create
    consumer = if ApiConsumer.exists?(email)
                 ApiConsumer.find_by email: email
               else
                 ApiConsumer.create_from_omniauth(auth_hash)
               end
    session[:user_id] = email
    response.cookies['Auth-Token'] = consumer.uid # TODO: return actual token
    redirect_to sessions_current_path
  end

  def destroy
    session[:user_id] = nil

    head :no_content
  end

  def current
    if session[:user_id].present?
      consumer = ApiConsumer.find_by email: session[:user_id]
      render json: { email: consumer.email, uid: consumer.uid }
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
