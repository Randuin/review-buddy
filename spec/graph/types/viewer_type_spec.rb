require "rails_helper"

RSpec.describe ViewerType, :type => :model do
  describe "currentUser field" do
    let(:subject) { ViewerType.fields["currentUser"] }
    let(:current_user) { User.new }

    it "resolves the current_user" do
      expect(subject.resolve(nil, nil, { current_user: current_user })).to eq(current_user)
    end
  end
end
