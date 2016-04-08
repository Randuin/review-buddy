require "rails_helper"

RSpec.describe GraphqlController, type: :controller do
  include Devise::TestHelpers

  describe "POST create" do
    let(:user) do
      user = create(:user)
      user.update_auth_token!
      user
    end

    it 'sets the currentUser when auth token is passed as a header' do
      @request.headers['Authorization'] = user.auth_token
      post :create, params: { query: 'query test { viewer { email } }' }

      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq({
        "data" => {
          "viewer" => {
            "email" => user.email
          }
        }
      })
    end
  end

  describe "GET introspection" do
    it 'returns the result of the INTROSPECTION_QUERY' do
      get :introspection
      expect(response.status).to eq(200)
    end
  end
end
