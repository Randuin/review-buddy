GithubOauthClient = OAuth2::Client.new(
  ENV["GITHUB_CLIENT_ID"],
  ENV["GITHUB_CLIENT_SECRET"],
  site: "https://api.github.com",
  token_url: "https://github.com/login/oauth/access_token",
  authorize_url: "https://github.com/login/oauth/authorize"
)
