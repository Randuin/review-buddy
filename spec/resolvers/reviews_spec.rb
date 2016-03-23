require "rails_helper"

RSpec.describe Resolvers::Reviews, :type => :model do
  describe "#call" do
    let(:user) { build(:user) }

    before do
      github_api_client = instance_double("Github")
      allow(Github).to receive(:new).with(user.github_access_token) { 
        github_api_client 
      }

      expect(github_api_client).to receive(:notifications)
        .and_return([{
          "id" => 1,
          "reason" => "mention",
          "unread" => true,
          "url" => "https://api.github.com/notifications/threads/1",
          "subject" => {
            "title" => "Test PR",
            "url" => "https://api.github.com/repos/octokit/octokit.rb/issues/123",
            "latest_comment_url" => "https://api.github.com/repos/octokit/octokit.rb/issues/comments/123",
            "type" => "Issue"
          },
        }, {
          "id" => 22,
          "reason" => "subscribed",
          "unread" => true,
          "url" => "https://api.github.com/notifications/threads/22",
          "subject" => {
            "title" => "No Mention",
            "url" => "https://api.github.com/repos/octokit/octokit.rb/issues/123",
            "latest_comment_url" => "https://api.github.com/repos/octokit/octokit.rb/issues/comments/123",
            "type" => "Issue"
          },
        }])
    end
    
    let (:subject) { Resolvers::Reviews.new.call(user, nil, nil) }

    it "gets new reviews from notifications for the user" do
      expect(subject.size).to eq(1) 
      expect(subject[0].title).to eq("Test PR")
    end

    context "with existing pull requests" do
      let(:user) { build(:user_with_prs) }

      it "adds new reviews from notifications to the existing ones" do
        expect(subject.size).to eq(2)
      end
    end
  end
end
