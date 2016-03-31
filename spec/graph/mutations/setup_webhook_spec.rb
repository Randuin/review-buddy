require 'spec_helper'

describe Mutations::SetupWebhook  do
    let(:query_string) {%|
    mutation setupWebhook {
      setupWebhook(input: { repoName: "reviewbuddy", clientMutationId: "1234" }) {
        clientMutationId
        repo {
          url
          name
          webhook_url
          webhook_id
        } 
      }
    }
  |}

  let(:current_user) { create(:user) }

  let (:result) { 
    GraphQL::Query.new(
      Schema,
      query_string,
      context: { current_user: current_user },
      debug: true
    ).result 
  }

  before do
    stub_request(:post, /api.github.com/)
      .to_return(status: 200, body: "{\"id\": 1, \"url\": \"test\"}")  
  end

  it "creates a new repo for the user" do
    expect { result }.to change {
      current_user.reload.repos.count 
    }.by(1)
  end

  it "calls github to setup a webhook" do
    expect(result).to eq({
      "data" => {
        "setupWebhook" => {
          "clientMutationId" => "1234",
          "repo" => {
            "url" => "https://github.com/xuorig/reviewbuddy",
            "name" => "reviewbuddy",
            "webhook_url" => "test",
            "webhook_id" => "1",
          }
        }
      }
    })
  end
end

