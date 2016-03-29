module Graph
  class ActiveRecordObjectType < GraphQL::ObjectType 
    attr_accessor :model
    accepts_definitions(:model)

    def connection_type
      Graph::Relay::Connection.type(self)
    end
  end
end
