require 'rails_helper'

RSpec.describe CommentIntent, :type => :model do
  describe "#review?" do
    it "returns true if comment indicates a review ping" do
      intent = CommentIntent.from("please review @xuorig")
      expect(intent.review?).to be(true)
    end

    it "returns true if comment indicates a review ping" do
      intent = CommentIntent.from("related to a change  @xuorig made")
      expect(intent.review?).to be(false)
    end
  end
end
