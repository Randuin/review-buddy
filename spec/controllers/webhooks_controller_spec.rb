require "rails_helper"

RSpec.describe WebhooksController, type: :controller do
  before do
    ActiveJob::Base.queue_adapter = :test
  end

  describe "POST comment" do
    it "enqueues a CommentWebHookJob with params" do
      expect {
        post :comment, params: { "issue" => { "id" => 1 }, "comment" => { "body" => "hello its me" } }
      }.to have_enqueued_job(CommentWebhookJob)
    end
  end

  describe "POST pr" do
    context "when action is closed" do
      it "enqueues a PullRequestWebhookJob with params" do
        expect {
          post :pr, params: { "pull_request" => { "id" => 1, "merged" => false }, "action" => "closed" }
        }.to have_enqueued_job(PullRequestWebhookJob)
      end
    end

    context "when action is other than closed" do
      it "does not enqueue the job" do
        expect {
          post :pr, params: { "pull_request" => { "id" => 1, "merged" => false }, "action" => "opened" }
        }.not_to have_enqueued_job(PullRequestWebhookJob)
      end
    end
 end
end
