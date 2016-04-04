class PullRequestWebhookJob < ApplicationJob
  queue_as :default

  def perform(pr_params)
  end
end
