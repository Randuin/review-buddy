require 'rails_helper'

RSpec.describe CommentWebhookJob, :type => :job do
  describe "#perform" do
    let(:user) { create(:user, github_uid: 1) }

    context "when comment body contains mentions" do
      let(:params) {
        {
          "issue" => {
            "number" => 123,
            "title" => "Great PR",
            "html_url" => "http://github.com/xuorig/something/pr",
          },
          "repository" => {
            "name" => "repo",
            "owner" => {
              "login" => "xuorig"
            }
          },
          "comment" => {
            "body" => "@xuorig please review"
          }
        }
      }

      before do
        stub_request(:get, /localhost:5000/)
          .to_return(status: 200, body: {intent: 'review'}.to_json)  

        github_public_client = instance_double("GithubPublic")
        allow(GithubPublic).to receive(:new) { github_public_client }

        expect(github_public_client).to receive(:user)
          .with('xuorig')
          .and_return({ "id" => 1 })
      end

      it "adds a pull request to the reviewers" do
        expect do
          described_class.new.perform(params)
        end.to change { user.reload.pull_requests.count }.by(1)
      end 
    end

    context "when comment body contains mentions but dont match any uses" do
      let(:params) {
        {
          "issue" => {
            "number" => 123,
            "title" => "Great PR",
            "html_url" => "http://github.com/xuorig/something/pr",
          },
          "repository" => {
            "name" => "repo",
            "owner" => {
              "login" => "xuorig"
            }
          },
          "comment" => {
            "body" => "@incognito please review"
          }
        }
      }

      before do
        stub_request(:get, /localhost:5000/)
          .to_return(status: 200, body: {intent: 'review'}.to_json)  

        github_public_client = instance_double("GithubPublic")
        allow(GithubPublic).to receive(:new) { github_public_client }
        expect(github_public_client).to receive(:user)
          .with('incognito')
          .and_return(nil)
      end

      it "does not add any pr to the user" do
        count = user.pull_requests.count
        expect do
          described_class.new.perform(params)
        end.not_to change { user.reload.pull_requests.count }.from(count)
      end 
    end
 
  end
end
