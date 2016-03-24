class CommentIntent
  REVIEW = 'review'.freeze

  class << self
    def from(comment_body)
      new(comment_body) 
    end
  end

  def initialize(comment_body)
    @body = comment_body
  end

  def intent
    # very dumb for now
    return REVIEW if @body.include?("please review")
  end

  def review?
    intent == REVIEW
  end
end
