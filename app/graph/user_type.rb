UserType = Graph::ActiveRecordObjectType.define do
  name "User"
  description "A Review Buddy User"
  interfaces [Graph::Relay::Node]
  model User

  field :email do
    type !types.String 
    resolve -> (obj, _, _) {
      obj.email
    }
  end

  field :reviews do
    type -> { types[!PullRequestType] }
    resolve Resolvers::Reviews.new
  end
end
