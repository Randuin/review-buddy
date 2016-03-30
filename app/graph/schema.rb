Schema = GraphQL::Schema.new(
  query: QueryType,
  mutation: MutationRoot,
  max_depth: 10,
)

