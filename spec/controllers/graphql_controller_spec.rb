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
      post :create, params: { query: 'query test { viewer { currentUser { email } } }' }

      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq({
        "data" => {
          "viewer" => {
            "currentUser" => {
              "email" => user.email
            }
          }
        }
      })
    end
  end
end
