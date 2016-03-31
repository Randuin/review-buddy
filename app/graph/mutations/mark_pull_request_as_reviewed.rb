module Mutations
  class MarkPullRequestAsReviewed < Graph::Relay::Mutation
    input :pullRequestId, GraphQL::STRING_TYPE
    returns :pullRequest, PullRequestType

    self.resolve = -> (obj, args, ctx) {
      pr = PullRequest.find(args["pullRequestId"])
      pr.update!(reviewed: true)
      { pullRequest: pr }
    }
  end
end

