require 'faraday'

class GithubPublic
  def initialize
    @conn = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
  end

  def user(username)
    response = @conn.get("/users/#{username}")
    return nil unless response.status == 200
    JSON.parse(response.body)
  end
end
