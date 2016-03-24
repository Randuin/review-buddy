class CommentWebhookJob < ApplicationJob
  queue_as :default

  def perform(params)
    comment = params["comment"]
    repo = params["repository"]
    sender = params["sender"]
    pr = params["issue"]

    new_pr = PullRequest.new(
      closed: false,
      reviewed: false,
      github_id: pr["id"],
      title: pr["title"],
      url: pr["url"]
    )

    reviewers = ReviewDetector.new(comment).infer_reviewers
    reviewers.each do |reviewer|
      reviewer.pull_requests << new_pr
    end
  end
end
