QueryType = GraphQL::ObjectType.define do
  name "Query"
  description "Root of the schema"

  # The Viewer class is just a wrapper/workaround to have 
  # fields with arguments on the query root.
  field :viewer do
    type UserType
    resolve -> (_, _, ctx) { ctx[:current_user] }
  end

  # Relay Spec Requirement
  field :node do
    type Graph::Relay::Node
    argument :id, !types.ID
    resolve -> (object, args, _) do
      gid = GlobalID.parse(args["id"])
      GlobalID::Locator.locate(gid)
    end
  end
end

