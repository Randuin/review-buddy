class WebhooksController < ApplicationController
  def comment
    CommentWebhookJob.perform_later(params.to_h)
    head :ok
  end
end
