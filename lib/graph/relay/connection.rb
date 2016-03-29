module Graph
  module Relay
    class Connection
      attr_reader :items, :page_info, :max_page_size

      def initialize(items, arguments, max_page_size:)
        @items = items
        @after = arguments[:after]
        @first = arguments[:first]

        @limit = [@first, max_page_size].compact.size 
        @max_page_size = max_page_size
      end

      class << self
        def type(object_type)
          GraphQL::ObjectType.define do
            name "#{object_type.name}Connection"     
            field :edges, types[Graph::Relay::Edge.type(object_type)]
            field :pageInfo, Graph::Relay::PageInfo.type, property: :page_info
          end
        end

        def field(name, type, max_page_size: 100)
          GraphQL::Field.define do 
          end
        end
      end

      def edges
        start_offset = get_offset_with_default(@after, 0)

        edges = edges_to_return.each_with_index.map do |edge, index| 
          Graph::Relay::Edge.new(edge, offset_to_cursor(start_offset + index))
        end

        edges
      end

      def page_info
        has_next_page = !!(@first && apply_cursor_to_edges.size > @first)
        Graph::Relay::PageInfo.new(false, has_next_page)
      end

      private

      def edges_to_return
        edges = apply_cursor_to_edges

        first = [@first, max_page_size].compact.min
        edges.first(first)
      end

      def apply_cursor_to_edges
        edges = items

        if @after
          after_edge_index = cursor_to_offset(@after) + 1  
          edges = edges[after_edge_index..-1]
        end

        edges
      end

      def get_offset_with_default(cursor, default_offset)
        cursor_to_offset(cursor) || default_offset
      end

      def offset_to_cursor(offset)
        return unless offset
        Base64.strict_encode64(offset.to_s)
      end

      def cursor_to_offset(cursor)
        return unless cursor
        Base64.decode64(cursor).to_i
      end
    end
  end
end

