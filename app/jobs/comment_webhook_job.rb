class CommentWebhookJob < ApplicationJob
  queue_as :default

  def perform(pr_params, comment_params)
    new_pr = PullRequest.new(
      closed: false,
      reviewed: false,
      github_id: pr_params["id"],
      title: pr_params["title"],
      url: pr_params["url"]
    )

    reviewers = ReviewDetector.new(comment_params).infer_reviewers
    reviewers.each do |reviewer|
      reviewer.pull_requests << new_pr
    end
  end
end
