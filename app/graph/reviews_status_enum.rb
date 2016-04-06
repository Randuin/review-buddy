ReviewsStatusEnum = GraphQL::EnumType.define do
  name "ReviewsStatus"
  description "Status for reviews"
  value("PENDING", "pending")
  value("REVIEWED", "reviewed")
end
