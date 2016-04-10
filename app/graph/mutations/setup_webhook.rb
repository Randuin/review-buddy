module Mutations
  class SetupWebhook < Graph::Relay::Mutation
    class Resolver
      def self.call(obj, args, ctx)
        return unless current_user = ctx[:current_user]
        repoName = args["repoName"]

        comment_response = current_user.client.setup_webhook(
          repoName,
          ['issue_comment'], 
          Rails.application.config.comment_webhook_url
        )

        pr_response = current_user.client.setup_webhook(
          repoName,
          ['pull_request'], 
          Rails.application.config.pr_webhook_url
        )

        webhook_params = JSON.parse(comment_response.body) 
        repo = current_user.repos.create!(
          url: "https://github.com/#{repoName}",
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

