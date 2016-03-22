QueryType = GraphQL::ObjectType.define do
  name "Query"
  description "Root of the schema"

  # The Viewer class is just a wrapper/workaround to have 
  # fields with arguments on the query root.
  field :viewer do
    type ViewerType
    resolve -> (_, _, _) { Class.new }
  end

  field :pull_request, PullRequestType
end

