class CommentIntent
  REVIEW = "review".freeze

  def initialize(comment_body)
    @conn = Faraday.new(url: Rails.application.config.intent_service_url) 
    @body = comment_body
  end

  def intent
    @response ||= begin
      response = @conn.get("/intent") { |req| req.params["comment"] = @body }
      return nil unless response.status == 200
      JSON.parse(response.body)["intent"]
    end
  end

  def review?
    intent == REVIEW
  end
end
