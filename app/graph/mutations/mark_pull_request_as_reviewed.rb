module Mutations
  class MarkPullRequestAsReviewed < Graph::Relay::Mutation
    class Resolver
      class << self
        def call(obj, args, ctx)
          pr = PullRequest.find(args["pullRequestId"])
          pr.update!(reviewed: true)
          { pullRequest: pr }
        end
      end
    end

    input :pullRequestId, GraphQL::STRING_TYPE
    returns :pullRequest, PullRequestType
    resolve_with Resolver
  end
end

