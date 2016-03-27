QueryType = GraphQL::ObjectType.define do
  name "Query"
  description "Root of the schema"

  # The Viewer class is just a wrapper/workaround to have 
  # fields with arguments on the query root.
  field :viewer do
    type ViewerType
    resolve -> (_, _, _) { Class.new }
  end

  field :node do
    type Graph::Relay::Node
    argument :id, !types.ID
    resolve -> (object, args, _) do
      gid = GlobalID.parse(args["id"])
      GlobalID::Locator.locate(gid)
    end
  end

  field :pull_request do
    type PullRequestType
    argument :model_id, !types.Int
    resolve -> (_, _, _) { PullRequest.new }
  end
end

