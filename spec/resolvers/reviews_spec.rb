require "rails_helper"

RSpec.describe Resolvers::Reviews, :type => :model do
  describe "#call" do
    let(:user) { build(:user_with_prs) }
    
    let (:subject) { Resolvers::Reviews.new.call(user, nil, nil) }

    it "gets reviews for the user" do
      expect(subject.size).to eq(1) 
    end
  end
end
