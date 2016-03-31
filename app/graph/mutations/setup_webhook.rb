module Mutations
  class SetupWebhook < Graph::Relay::Mutation
    class Resolver
      def self.call(obj, args, ctx)
        return unless current_user = ctx[:current_user]
        repoName = args["repoName"]

        response = current_user.client.setup_webhook(repoName)
        raise StandardError, "Something went wrong" unless response.status == 200

        webhook_params = JSON.parse(response.body) 
        repo = current_user.repos.create!(
          url: "https://github.com/#{current_user.github_username}/#{repoName}",
          name: repoName,
          webhook_url: webhook_params["url"],
          webhook_id: webhook_params["id"]
        )

        { repo: repo }
      end
    end

    input :repoName, GraphQL::STRING_TYPE
    returns :repo, RepoType
    resolve_with Resolver
  end
end

