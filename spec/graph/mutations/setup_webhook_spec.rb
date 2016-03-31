require 'spec_helper'

describe Mutations::SetupWebhook  do
    let(:query_string) {%|
    mutation setupWebhook {
      setupWebhook(input: { repoName: "reviewbuddy", clientMutationId: "1234" }) {
        clientMutationId
        repoName 
      }
    }
  |}

  let (:result) { 
    GraphQL::Query.new(
      Schema,
      query_string,
      context: {
        current_user: build(:user)
      },
      debug: true
    ).result 
  }

  before do
    stub_request(:post, /api.github.com/)
      .to_return(status: 200, body: "{\"id\": 1}")  
  end

  it "calls github to setup a webhook" do
    expect(result).to eq({
      "data" => {
        "setupWebhook" => {
          "clientMutationId" => "1234",
          "repoName" => "reviewbuddy",
        }
      }
    })
  end
end

