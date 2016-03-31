RepoType = Graph::ActiveRecordObjectType.define do
  name "Repo"
  description "A Github repository"
  interfaces [Graph::Relay::Node]
  model Repo

  field :url, !types.String, property: :url
  field :name, !types.String, property: :name
  field :webhook_url, !types.String, property: :webhook_url
  field :webhook_id, !types.String, property: :webhook_id
end
