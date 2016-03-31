class WebhooksController < ApplicationController
  def comment
    CommentWebhookJob.perform_later(pr_params.to_h, comment_params.to_h)
    head :ok
  end


  def pr_params
    params.require(:issue).permit(:id, :title, :url)
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
