require 'rails_helper'

RSpec.describe User, :type => :model do
  describe "#update_auth_token" do
    it "generates an auth token for user" do
      subject.id = 14
      subject.update_auth_token
      expect(subject.auth_token).to match(/14:.+/)
    end
  end

  describe "#reviews" do
    it "returns all non-reviewed prs the user has been pinged on" do
      subject.pull_requests << PullRequest.new(reviewed: true)
      subject.pull_requests << PullRequest.new(reviewed: false)
      expect(subject.reviews.size).to eq(1)
    end
  end
end
