module Graph
  module Relay
    class Edge
      attr_accessor :node, :cursor 

      def initialize(node, cursor)
        @node = node
        @cursor = cursor
      end
    end
  end
end
