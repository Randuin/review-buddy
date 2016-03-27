require "rails_helper"

RSpec.describe QueryType, :type => :model do
  describe "node field" do
    let(:subject) { QueryType.fields["node"] }
    let(:user) { create(:user, id: 1) }
    let(:user_gid) { user.to_global_id }
    let(:result) { subject.resolve(nil, {"id" => user_gid}, nil) }

    it "gets a global id for an object" do
      expect(result).to eq(user)
    end
  end
end
