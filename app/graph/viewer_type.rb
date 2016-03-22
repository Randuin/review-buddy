ViewerType = GraphQL::ObjectType.define do
  name "Viewer"
  description "Represents viewer of an Application"

  field :currentUser do
    type UserType
    resolve -> (_, _, ctx) {
      ctx[:current_user]
    }
  end
end
