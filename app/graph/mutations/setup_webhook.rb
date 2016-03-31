module Mutations
  class SetupWebhook < Graph::Relay::Mutation
    input :repoName, GraphQL::STRING_TYPE
    # TODO: Return an actual repo object ?
    returns :repoName, GraphQL::STRING_TYPE

    self.resolve = -> (obj, args, ctx) {
      return unless current_user = ctx[:current_user]
      repoName = args["repoName"]

      current_user.client.setup_webhook(repoName)
      { repoName: repoName }
    }
  end
end

