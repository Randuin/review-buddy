require 'github_public'

class ReviewDetector
  class Mention
    def initialize(username)
      @username = username
    end

    def user
      gh_user = GithubPublic.new.user(@username)
      require 'pry'
      User.find_by(github_uid: gh_user["id"])
    end
  end

  attr_reader :params

  def initialize(comment_params)
    @params = comment_params
  end

  def infer_reviewers
    return [] unless is_review_ping?
    return [] unless mentions.present?
    mentions.map(&:user).compact
  end

  private

  def is_review_ping?
    # TODO: This is super dumb right now. Make it more intelligent
    @params["body"].include?("please review")
  end

  def mentions
    usernames = @params["body"].scan(/(?<!\w)@(\w+)/)
    @mentions ||=
      usernames.flatten.map { |name| Mention.new(name) }
  end
end
