MutationRoot = GraphQL::ObjectType.define do
  name "Mutation"

  field :markPullRequestAsReviewed, MarkPullRequestAsReviewed.field 
end
