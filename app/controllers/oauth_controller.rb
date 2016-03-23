require 'github'

class OauthController < ApplicationController
  def github
    token = GithubOauthClient.auth_code.get_token(params['code'])
    user_data = Github.new(token).user
    user = User.from_github(token.token, user_data)
    sign_in user
  end
end
