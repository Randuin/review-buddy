require 'rails_helper'

RSpec.describe User, :type => :model do
  describe "#update_auth_token" do
    before do
      subject.id = 14
      subject.update_auth_token
    end

    it "generates an auth token for user" do
      expect(subject.auth_token).to match(/14:.+/)
    end
  end

  describe "#reviews" do
    before do
      subject.pull_requests << PullRequest.new(reviewed: true)
      subject.pull_requests << PullRequest.new(reviewed: false)
    end

    it "returns all non-reviewed prs the user has been pinged on" do
      expect(subject.reviews.size).to eq(1)
    end
  end

  describe ".from_github" do
    let(:email) { "yoloswag@sniper.com" }
    let(:github_uid) { "yabcde1234fegt" }

    let(:github_data) {
      { 
        "email" => email,
        "avatar_url" => "https://cdn.swag.com/123asd",
        "id" => github_uid,
      }
    }

    let(:access_token) { "yolasdjasdj123" }

    let(:subject) {
      User.from_github(access_token, github_data)
    }

    it "creates a new user from github data" do
      expect(subject.email).to eq(email)
      expect(subject.github_uid).to eq(github_uid)
      expect(subject.github_access_token).to eq(access_token)
    end

    it "returns the user if it exists already with github id" do
      new_user = User.from_github(access_token, github_data)
      expect(subject).to eq(new_user)
    end
  end
end
