class ApplicationController < ActionController::API
  def authenticate_user_from_token!
    auth_token = request.headers['Authorization']
    return nil unless auth_token
    authenticate_with_auth_token(auth_token)
    current_user
  end

  def authenticate_with_auth_token(auth_token)
    return authentication_error unless auth_token.include?(':')

    user_id = auth_token.split(':').first
    user = User.where(id: user_id).first

    if user && Devise.secure_compare(user.access_token, auth_token)
      sign_in user, store: false
    end
  end
end
