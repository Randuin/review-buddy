require 'rails_helper'
require 'github_public'

RSpec.describe GithubPublic, :type => :model do
  describe "#user" do
    context "when API returns 200" do
      before do
        stub_request(:get, /api.github.com/)
          .to_return(status: 200, body: {id: 1}.to_json)  
      end

      it "returns the payload" do
        expect(GithubPublic.new.user("yoloswager")).to eq({"id" => 1})
      end
    end

    context "when API returns 404" do
      before do
        stub_request(:get, /api.github.com/)
          .to_return(status: 404, body: "")  
      end

      it "returns nil" do
        expect(GithubPublic.new.user("yoloswager")).to be_nil
      end
    end
  end
end
