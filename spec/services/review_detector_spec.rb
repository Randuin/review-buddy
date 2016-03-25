require 'rails_helper'

RSpec.describe ReviewDetector, :type => :model do
  describe "#infer_reviewers" do
    let(:subject) { 
      ReviewDetector.new(comment_params) 
    } 

    context "when body is a review ping" do
      before do
        stub_request(:get, /localhost:5000/)
          .to_return(status: 200, body: {intent: 'review'}.to_json)  
      end

      context "when comment body contains mentions" do
        let(:comment_params) do
          {
            "body" => "@xuorig please review!"
          }
        end

        before do
          create(:user, github_uid: 1)

          github_public_client = instance_double("GithubPublic")
          allow(GithubPublic).to receive(:new) { github_public_client }

          expect(github_public_client).to receive(:user)
            .with('xuorig')
            .and_return({"id" => 1})
        end

        it "returns list of users found in comment body" do
          expect(subject.infer_reviewers.size).to eq(1)
        end
      end

      context "when comment body contains no mentions" do
        let(:comment_params) do
          {
            "body" => "please review!"
          }
        end

        it "returns an empty array" do
          expect(subject.infer_reviewers).to eq([])
        end
      end

    end

    context "when comment body is a regular comment" do
      before do
        stub_request(:get, /localhost:5000/)
          .to_return(status: 200, body: {intent: 'comment'}.to_json)  
      end

      let(:comment_params) do
        {
          "body" => "@xuorig what do you think?"
        }
      end

      it "returns an empty array" do
        expect(subject.infer_reviewers).to eq([])
      end
    end
  end
end
