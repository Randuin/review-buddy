module Graph
  class ActiveRecordObjectType < GraphQL::ObjectType 
    attr_accessor :model
    accepts_definitions(:model)
  end
end
