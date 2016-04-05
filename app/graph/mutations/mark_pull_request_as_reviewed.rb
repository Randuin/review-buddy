module Mutations
  class MarkPullRequestAsReviewed < Graph::Relay::Mutation
    class Resolver
      class << self
        def call(obj, args, ctx)
          pr = PullRequest.find(args["pullRequestId"])
          pr.update!(reviewed: true)
          { reviewedReviewId: pr.to_global_id, currentUser: ctx[:current_user] }
        end
      end
    end

    input :pullRequestId, GraphQL::INT_TYPE
    returns :reviewedReviewId, GraphQL::ID_TYPE
    returns :currentUser, UserType
    resolve_with Resolver
  end
end

