class WebhooksController < ApplicationController
  def comment
    CommentWebhookJob.perform_later(issue_params.to_h, comment_params.to_h)
    head :ok
  end

  def pr
    if request.request_parameters["action"] == 'closed'
      PullRequestWebhookJob.perform_later(pr_params.to_h)
    end
    head :ok
  end

  def pr_params
    params.require(:pull_request).permit(:id, :merged)
  end

  def issue_params
    params.require(:issue).permit(:id, :title, :url)
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
