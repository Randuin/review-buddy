require 'rails_helper'

RSpec.describe CommentIntent, :type => :model do
  describe "#review?" do
    context "when intent service detects review intent" do
      before do
        stub_request(:get, /localhost:5000/)
          .to_return(status: 200, body: {intent: 'review'}.to_json)  
      end

      it "returns true" do
        intent = CommentIntent.new("please review @xuorig")
        expect(intent.review?).to be(true)
      end
    end
    
    context "when intent service something else than a review" do
      before do
        stub_request(:get, /localhost:5000/)
          .to_return(status: 200, body: {intent: 'comment'}.to_json)  
      end

      it "returns false" do
        intent = CommentIntent.new("related to a change  @xuorig made")
        expect(intent.review?).to be(false)
      end
    end
  end
end
