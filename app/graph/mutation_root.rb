MutationRoot = GraphQL::ObjectType.define do
  name "Mutation"

  field :markPullRequestAsReviewed, field: Mutations::MarkPullRequestAsReviewed.field 
end
