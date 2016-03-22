class Github
  def initialize(access_token)
    # here, token is a Oauth2::AccessToken
    # used to make requests
    @token = access_token
  end

  def get_user
    response = @token.get('/user').response
    JSON.parse(response.body)
  end
end
