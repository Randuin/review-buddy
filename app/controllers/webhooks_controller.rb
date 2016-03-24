class WebhooksController < ApplicationController
  def comment
    CommentWebhookJob.perform_later(params)
    head :ok
  end
end
