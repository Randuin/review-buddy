module Mutations
  class MarkPullRequestAsReviewed < Graph::Relay::Mutation
    input :pullRequestId, GraphQL::STRING_TYPE

    returns :id, GraphQL::STRING_TYPE
    returns :reviewed, GraphQL::BOOLEAN_TYPE

    self.resolve = -> (obj, args, ctx) {
      obj.reviewed = true 
      obj.save!
      obj
    }
  end
end

