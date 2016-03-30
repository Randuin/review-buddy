require 'spec_helper'

describe Mutations::MarkPullRequestAsReviewed do
    let(:query_string) {%|
    mutation markPullRequestAsReviewed {
      markPullRequestAsReviewed(input: { pullRequestId: "1", clientMutationId: "1234" }) {
        clientMutationId
        pullRequest { reviewed, id }
      }
    }
  |}

  let (:result) { GraphQL::Query.new(Schema, query_string, debug: true).result }

  before do
    create(:pull_request, id: 1)
  end

  it "marks a pull request as reviewed" do
    expect(result).to eq({
      "data" => {
        "markPullRequestAsReviewed" => {
          "clientMutationId" => "1234",
          "pullRequest" => {
            "reviewed" => true,
            "id" => "gid://review-buddy/PullRequest/1"
          }
        }
      }
    })
  end
end

