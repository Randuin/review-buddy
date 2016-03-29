module Graph
  module Relay
    class Edge
      attr_accessor :node, :cursor 

      def initialize(node, cursor)
        @node = node
        @cursor = cursor
      end

      class << self
        def type(object_type)
          GraphQL::ObjectType.define do
            name "#{object_type.name}Edge"     
            field :node, object_type 
            field :cursor, !types.String
          end
        end
      end
    end
  end
end
