class CommentWebhookJob < ApplicationJob
  queue_as :default

  def perform(params)
    pr = PullRequest.new(
      closed: false,
      reviewed: false,
      merged: false,
      repo:  params["repository"]["name"],
      owner:  params["repository"]["owner"]["login"],
      number: params["issue"]["number"],
      title: params["issue"]["title"],
      url: params["issue"]["html_url"]
    )

    reviewers = ReviewDetector.new(params["comment"]).infer_reviewers

    Rails.logger.info "Could not infer any reviewers for comment: #{params["comment"]["body"]}" if reviewers.blank?

    reviewers.each do |reviewer|
      reviewer.pull_requests << pr
    end
  end
end
