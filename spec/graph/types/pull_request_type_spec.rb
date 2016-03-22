require "rails_helper"

RSpec.describe PullRequestType, :type => :model do
  let(:pr) { build(:pull_request) }
  let(:resolved) { subject.resolve(pr, nil, nil) }

  describe "github_id field" do
    let(:subject) { PullRequestType.fields["github_id"] }

    it "resolves to the pr github_id" do
      expect(resolved).to eq(pr.github_id)
    end
  end

  describe "title field" do
    let(:subject) { PullRequestType.fields["title"] }

    it "resolves to the pull request title" do
      expect(resolved).to eq(pr.title) 
    end
  end

  describe "user field" do
    let(:subject) { PullRequestType.fields["users"] }

    it "resolves to the pull request user" do
      expect(resolved).to eq(pr.users) 
    end
  end

  describe "url field" do
    let(:subject) { PullRequestType.fields["url"] }

    it "resolves to the pull request url" do
      expect(resolved).to eq(pr.url) 
    end
  end

  describe "reviewed field" do
    let(:subject) { PullRequestType.fields["reviewed"] }

    it "resolves to the pull request review status" do
      expect(resolved).to eq(pr.reviewed) 
    end
  end

  describe "closed field" do
    let(:subject) { PullRequestType.fields["closed"] }

    it "resolves to the pull request closed status" do
      expect(resolved).to eq(pr.closed) 
    end
  end
end
