class ClosePullRequestJob < ApplicationJob
  queue_as :default

  def perform(params)
    pr = PullRequest.find_by(
      repo: params[:repository][:name],
      owner: params[:repository][:owner][:login],
      number: params[:number],
    )
    return unless pr

    if params[:pull_request][:title] != pr.title
      pr.title = params[:pull_request][:title]
      broadcast_pr_change(pr)
    end

    pr.closed = true
    pr.merged = params[:pull_request][:merged]
    pr.save!
  end

  def broadcast_pr_change(pr)
    ActionCable.server.broadcast 'pull_requests',
      pull_request: {
      id: pr.to_global_id.to_s,
        title: pr.title
      }
  end
end
