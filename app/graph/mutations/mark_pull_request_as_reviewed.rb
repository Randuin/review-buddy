module Mutations
  class MarkPullRequestAsReviewed < Graph::Relay::Mutation
    input :pullRequestId, GraphQL::STRING_TYPE
    returns :pullRequest, PullRequestType

    self.resolve = -> (obj, args, ctx) {
      pr = PullRequest.find(args["pullRequestId"])
      pr.reviewed = true 
      pr.save!
      { pullRequest: pr }
    }
  end
end

