require 'github_public'

class ReviewDetector
  class Mention
    def initialize(username)
      @username = username
    end

    def user
      gh_user = GithubPublic.new.user(@username)
      return unless gh_user
      User.find_by(github_uid: gh_user["id"])
    end
  end

  attr_reader :params

  def initialize(comment_params)
    @params = comment_params
  end

  def infer_reviewers
    return [] unless mentions.present?
    return [] unless is_review_ping?
    mentions.map(&:user).compact
  end

  private

  def is_review_ping?
    CommentIntent.new(@params["body"]).review?
  end

  def mentions
    usernames = @params["body"].scan(/(?<!\w)@(\w+)/)
    @mentions ||=
      usernames.flatten.map { |name| Mention.new(name) }
  end
end
