module Mutations
  class MarkPullRequestAsReviewed < Graph::Relay::Mutation
    class Resolver
      class << self
        def call(obj, args, ctx)
          pr = PullRequest.find(args["pullRequestId"])
          pr.update!(reviewed: true)
          { viewer: ctx[:current_user] }
        end
      end
    end

    input :pullRequestId, GraphQL::INT_TYPE
    returns :viewer, UserType
    resolve_with Resolver
  end
end

