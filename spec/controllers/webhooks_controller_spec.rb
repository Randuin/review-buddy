require "rails_helper"

RSpec.describe WebhooksController, type: :controller do
  before do
    ActiveJob::Base.queue_adapter = :test
  end

  describe "POST comment" do
    it "enqueues a CommentWebHookJob with params" do
      expect {
        post :comment, params: { 
          "issue" => { 
            "number" => 1,
          }, 
          "repository" => {
            "name" => "coolrepo",
            "owner" => {
              "login" => "cooluser", 
            } 
          },
          "comment" => { 
            "body" => "hello its me" 
          } 
        }
      }.to have_enqueued_job(CommentWebhookJob)
    end
  end

  describe "POST pr" do
    context "when action is closed" do
      it "enqueues a ClosePullRequestJob with params" do
        expect {
          post :pr, params: { 
            "pull_request" => { 
              "merged" => false
            },
            "repository" => {
              "name" => "coolrepo",
              "owner" => {
                "login" => "cooluser", 
              } 
            },
            "action" => "closed",
            "number" => "1"
          }
        }.to have_enqueued_job(ClosePullRequestJob)
      end
    end

    context "when action is other than closed" do
      it "does not enqueue the job" do
        expect {
          post :pr, params: { 
            "pull_request" => { 
              "user" => {
                "login" => "cooluser"
              },
              "repo" => {
                "name" => "coolrepo"
              },
              "merged" => false
            }, 
            "action" => "open",
            "number" => "1"
          }
        }.not_to have_enqueued_job(ClosePullRequestJob)
      end
    end
 end
end
