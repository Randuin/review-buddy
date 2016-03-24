class Github
  attr_accessor :token

  def initialize(access_token)
    if access_token.is_a?(String)
      @token = OAuth2::AccessToken.new(GithubOauthClient, access_token) 
    else
      @token = access_token
    end
  end

  def get(url)
    response = @token.get(url).response
    JSON.parse(response.body)
  end

  def notifications
    get('/notifications?participating=true') 
  end

  def user
    get('/user')
  end
end
