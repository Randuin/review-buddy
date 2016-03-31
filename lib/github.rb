class Github
  attr_accessor :token

  def initialize(access_token)
    if access_token.is_a?(String)
      @token = OAuth2::AccessToken.new(GithubOauthClient, access_token) 
    else
      @token = access_token
    end
  end

  def user
    get('/user')
  end

  def setup_webhook(repoName)
    post("/repos/xuorig/#{repoName}/hooks", 
      name: 'web',       
      config: { url: Rails.application.config.webhook_url, content_type: 'json'}, 
      events: ['commit_comment'], 
    )
  end
  
  private

  def post(url, body = {})
    @token.post(url, body: JSON.dump(body))
  end

  def get(url)
    response = @token.get(url).response
    JSON.parse(response.body)
  end
end
