UserType = Graph::ActiveRecordObjectType.define do
  name "User"
  description "A Review Buddy User"
  interfaces [Graph::Relay::Node]
  model User

  field :email, !types.String, property: :email

  # TODO make connection field a thing
  field :reviews do
    type -> { PullRequestType.connection_type }

    argument :first, types.Int
    argument :after, types.String
    argument :status, ReviewsStatusEnum

    resolve -> (user, arguments, _) do
      status = arguments["status"]
      connection = status == "PENDING" ? user.reviews : user.reviewed

      Graph::Relay::Connection.new(
        connection,
        arguments,
        max_page_size: 50, 
      ) 
    end
  end
end
