class PullRequestsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'pull_requests'
  end
end
