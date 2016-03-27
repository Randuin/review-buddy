module Graph
  class ActiveRecordObjectType < GraphQL::ObjectType 
    attr_accessor :model
    accepts_definitions(:model)

    def connection_type
      type_name = self.name
      edge_type = self.edge_type

      @connection_type ||= GraphQL::ObjectType.define do
        name "#{type_name}Connection"     
        field :edges, edge_type 
        field :pageInfo, Graph::Relay::PageInfo
      end
    end

    def edge_type
      type = self

      @edge_type ||= GraphQL::ObjectType.define do
        name "#{type.name}Edge"     
        field :node, type 
        field :cursor, !types.String
      end
    end
  end
end
