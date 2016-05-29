class WebhooksController < ApplicationController
  def comment
    CommentWebhookJob.perform_later(comment_params.to_h)
    head :ok
  end

  def pr
    # TODO: Change name to UpdatePullRequestJob
    ClosePullRequestJob.perform_later(pr_params.to_h)

    head :ok
  end

  def comment_params
    params.permit(
      issue: [
        :number,
        :title,
        :html_url
      ],
      repository: [
        :name,
        owner: [
          :login
        ]
      ],
      comment: [
        :body
      ]
    )
  end

  def pr_params
    params.permit(
      :action,
      :number,
      repository: [
        :name,
        {
          owner: [
            :login
          ]
        }
      ],
      pull_request: [
        :title,
        :merged
      ]
    )
  end
end
