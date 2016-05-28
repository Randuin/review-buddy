module Graph
  module Relay
    Node = GraphQL::InterfaceType.define do
      name "Node"
      field :id, !types.ID, property: :to_global_id

      resolve_type -> (object, ctx) do
        ctx.schema.possible_types(self).detect do |type|
          object.is_a?(type.model)
        end
      end
    end
  end
end
