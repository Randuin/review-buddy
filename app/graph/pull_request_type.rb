PullRequestType = Graph::ActiveRecordObjectType.define do
  name "PullRequest"
  description "A Github pull request"
  interfaces [Graph::Relay::Node]
  model PullRequest

  field :github_id, types.Int, property: :github_id
  field :title, types.String, property: :title
  field :users, UserType, property: :users
  field :url, types.String, property: :url
  field :reviewed, types.Boolean, property: :reviewed
  field :closed, types.Boolean, property: :closed
end

