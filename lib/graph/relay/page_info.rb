PageInfo = GraphQL::ObjectType.define do
  name "PageInfo"
  field :hasPreviousPage, !types.Boolean, property: :has_previous_page
  field :hasNextPage, !types.Boolean, property: :has_next_page
end
