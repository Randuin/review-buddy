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

  describe "repos field" do
    let(:subject) { UserType.fields["repos"] }
    let(:user) { build(:user) }
    let(:resolved) { subject.resolve(user, nil, nil) }

    it "resolves the pull requests not yet reviewed by user" do
      expect(resolved.size).to eq(1)
      expect(resolved[0].name).to eq('test-repo')
    end
  end

  describe "reviews connection" do
    let(:subject) { UserType.fields["reviews"] }
    let(:user) { build(:user_with_prs) }

    context "when status argument is PENDING" do
      let(:resolved) { 
        subject.resolve(user, { "first" => 10, "status" => "PENDING" }, nil) 
      }

      it "returns the pending reviews for the user" do
        expect(resolved).to be_a(Graph::Relay::Connection)
        expect(resolved.items).to all(have_attributes(reviewed: false))
      end
    end

    context "when status argument is REVIEWED" do
      let(:resolved) { 
        subject.resolve(user, { "first" => 10, "status" => "REVIEWED" }, nil) 
      }

      it "returns the reviewed reviews for the user" do
        expect(resolved).to be_a(Graph::Relay::Connection)
        expect(resolved.items).to all(have_attributes(reviewed: true))
      end
    end
  end
end
