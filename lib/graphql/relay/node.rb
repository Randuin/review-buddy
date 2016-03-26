module GraphQL
  module Relay
    NodeInterface = GraphQL::InterfaceType.define do
      name "Node"
      field :id, !types.ID
      resolve_type -> (object) do
        GraphQL::Relay::NodeInterface.possible_types[object]
      end
    end
  end
end
