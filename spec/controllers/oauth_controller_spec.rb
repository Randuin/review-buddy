require "rails_helper"

RSpec.describe OauthController, type: :controller do
  include Devise::TestHelpers

  describe "GET github" do
    let(:email) { "yolosniper@swag.ca" }

    before do
      auth_code = instance_double("OAuth2::Strategy::AuthCode")
      github_api_client = instance_double("Github")
      access_token = double(token: 'an_access_token')

      allow(GithubOauthClient).to receive(:auth_code) { auth_code } 
      allow(Github).to receive(:new).with(access_token) { github_api_client }

      expect(auth_code).to receive(:get_token)
        .with('an_authorization_code')
        .and_return(access_token)

      expect(github_api_client).to receive(:get_user)
        .and_return({
          "id" => "abcd123",
          "email" => email,
        })
    end

    it "handles github oauth callback" do
      get :github, params: { code: 'an_authorization_code' }
      expect(subject.current_user.email).to eq(email)
    end
  end
end
