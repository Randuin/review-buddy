UserType = GraphQL::ObjectType.define do
  name "User"
  description "A Review Buddy User"

  field :email do
    type !types.String 
    resolve -> (obj, _, _) {
      obj.email
    }
  end

  field :reviews do
    type -> { types[!PullRequestType] }
    resolve -> (obj, args, ctx) {
      obj.reviews 
    }
  end
end
