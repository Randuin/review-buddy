PullRequestType = GraphQL::ObjectType.define do
  name "PullRequest"
  description "A Github pull request"

  field :github_id do
    type types.Int
    resolve -> (obj, _, _) {
      obj.github_id 
    }
  end

  field :title do
    type types.String
    resolve -> (obj, _, _) {
      obj.title 
    }
  end

  field :users do
    type UserType
    resolve -> (obj, _, _) {
      obj.users 
    }
  end

  field :url do
    type types.String
    resolve -> (obj, _, _) {
      obj.url 
    }
  end

  field :reviewed do
    type types.Boolean
    resolve -> (obj, _, _) {
      obj.reviewed 
    }
  end

  field :closed do
    type types.Boolean
    resolve -> (obj, _, _) {
      obj.closed 
    }
  end
end

