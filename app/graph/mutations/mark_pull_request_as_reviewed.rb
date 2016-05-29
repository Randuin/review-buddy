module Mutations
  class MarkPullRequestAsReviewed < Graph::Relay::Mutation
    class Resolver
      class << self
        def call(obj, args, ctx)
          pr = PullRequest.find(args["pullRequestId"])
          pr.update!(reviewed: true)

          ActionCable.server.broadcast 'pull_requests',
            pull_request: pr

          { viewer: ctx[:current_user] }
        end
      end
    end

    input :pullRequestId, GraphQL::INT_TYPE
    returns :viewer, UserType
    resolve_with Resolver
  end
end

