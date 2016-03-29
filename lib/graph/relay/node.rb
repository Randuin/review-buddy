module Graph
  module Relay
    Node = GraphQL::InterfaceType.define do
      name "Node"
      field :id, !types.ID, property: :to_global_id

      resolve_type -> (object) do
        Graph::Relay::Node.possible_types.detect do |type|
          object.is_a?(type.model)
        end
      end
    end
  end
end
