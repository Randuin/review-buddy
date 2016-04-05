require 'spec_helper'

describe Mutations::MarkPullRequestAsReviewed do
    let(:query_string) {%|
    mutation markPullRequestAsReviewed {
      markPullRequestAsReviewed(input: { pullRequestId: 1, clientMutationId: "1234" }) {
        clientMutationId
      }
    }
  |}

  let (:result) { GraphQL::Query.new(Schema, query_string, context: {}, debug: true).result }

  before do
    create(:pull_request, id: 1)
  end

  it "marks a pull request as reviewed" do
    expect(result).to eq({
      "data" => {
        "markPullRequestAsReviewed" => {
          "clientMutationId" => "1234",
        }
      }
    })
  end
end

