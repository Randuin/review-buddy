require "rails_helper"

RSpec.describe Graph::Relay::Node, :type => :model do
  describe "id field" do
    let(:subject) { Graph::Relay::Node.fields["id"] }
    let(:user) { build(:user, id: 1) }
    let(:result) { subject.resolve(user, nil, nil) }

    it "gets a global id for an object" do
      expect(result).to be_a(GlobalID)
    end

    it "returns a global id with the correct model name" do
      expect(result.model_name).to eq("User")
    end

    it "returns a global id with the correct model id" do
      expect(result.model_id).to eq("1")
    end
  end
end
