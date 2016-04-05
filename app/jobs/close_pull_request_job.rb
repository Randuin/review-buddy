class ClosePullRequestJob < ApplicationJob
  queue_as :default

  def perform(params)
    pr = PullRequest.find_by(
      repo: params[:repository][:name],
      owner: params[:repository][:owner][:login],
      number: params[:number],
    )
    return unless pr

    pr.closed = true
    pr.merged = params[:pull_request][:merged]
    pr.save!
  end
end
