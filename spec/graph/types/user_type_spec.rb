require "rails_helper"

RSpec.describe UserType, :type => :model do
  describe "email field" do
    let(:subject) { UserType.fields["email"] }
    let(:user) { build(:user) }
    let(:resolved) { subject.resolve(user, nil, nil) }

    it "resolves the pull requests not yet reviewed by user" do
      expect(resolved).to match(/person\d+@example\.com/)
    end
  end
end
