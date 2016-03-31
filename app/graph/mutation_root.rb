MutationRoot = GraphQL::ObjectType.define do
  name "Mutation"

  field :markPullRequestAsReviewed, field: Mutations::MarkPullRequestAsReviewed.field 
  field :setupWebhook, field: Mutations::SetupWebhook.field 
end
