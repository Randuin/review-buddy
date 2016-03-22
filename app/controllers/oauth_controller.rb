require 'github'

class OauthController < ApplicationController
  def github
    client = OAuth2::Client.new(
      ENV["GITHUB_CLIENT_ID"],
      ENV["GITHUB_CLIENT_SECRET"],
      site: "https://api.github.com",
      token_url: "https://github.com/login/oauth/access_token",
      authorize_url: "https://github.com/login/oauth/authorize"
    )
    token = client.auth_code.get_token(params['code'])
    # TODO: explore putting this in a job ?
    user_data = Github.new(token).get_user
    user = User.from_github(user_data)
    sign_in user
  end
end
