QueryType = GraphQL::ObjectType.define do
  name "Query"
  description "Root of the schema"

  # The Viewer class is just a wrapper/workaround to have 
  # fields with arguments on the query root.
  field :viewer, ViewerType, -> (_, _, _) { nil }

  field :pull_request, PullRequestType
end

