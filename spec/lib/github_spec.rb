require 'rails_helper'
require 'github'

RSpec.describe Github, :type => :model do
  describe "#user" do
    let(:token) { instance_double("OAuth2::AccessToken") }

    it "gets /user" do
      expect(token).to receive(:get).with('/user') { 
        double(response: double(body: { user: 1 }.to_json)) 
      }

      Github.new(token).user
    end
  end
end
