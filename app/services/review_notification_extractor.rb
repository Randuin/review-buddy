class ReviewNotificationExtractor
  MENTION = 'mention'.freeze

  def initialize(notifications)
    @notifications = notifications
  end

  def extract_reviews
    mentions_only.map do |mention|
      PullRequest.new(
        github_id: mention["id"],
        closed: false,
        reviewed: false,
        title: mention["subject"]["title"],
        url: mention["subject"]["url"]
      )
    end
  end

  private

  def mentions_only
    @notifications.select { |notification| notification["reason"] == MENTION }
  end
end
