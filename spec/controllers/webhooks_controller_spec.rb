require "rails_helper"

RSpec.describe WebhooksController, type: :controller do
  describe "POST comment" do
    it "enqueues a CommentWebHookJob with params" do
      post :comment, params: { "issue" => { "id" => 1 }, "comment" => { "body" => "hello its me" } }
    end
  end
end
