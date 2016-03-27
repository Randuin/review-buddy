module Graph
  module Relay
    class Connection
      attr_accessor :edges, :page_info

      def initialize(edges, page_info)
        @edges = edges
        @page_info = page_info
      end
    end
  end
end
