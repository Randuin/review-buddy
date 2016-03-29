UserType = Graph::ActiveRecordObjectType.define do
  name "User"
  description "A Review Buddy User"
  interfaces [Graph::Relay::Node]
  model User

  field :email, !types.String, property: :email

  field :reviews do
    type -> { PullRequestType.connection_type }

    argument :first, types.Int
    argument :after, types.String

    resolve -> (user, arguments, _) do
      Graph::Relay::Connection.new(
        user.reviews,
        arguments,
        max_page_size: 50, 
      ) 
    end
  end
end
