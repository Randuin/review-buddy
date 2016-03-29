module Graph
  module Relay
    class PageInfo
      attr_reader :has_previous_page, :has_next_page

      def initialize(has_previous_page, has_next_page)
        @has_previous_page = has_previous_page
        @has_next_page = has_next_page
      end

      class << self
        def type
          GraphQL::ObjectType.define do
            name "PageInfo"
            field :hasPreviousPage, !types.Boolean, property: :has_previous_page
            field :hasNextPage, !types.Boolean, property: :has_next_page
          end
        end
      end
    end
  end
end
