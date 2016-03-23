module Resolvers
  class Reviews
    def call(user, args, ctx)
      # TODO: Call to github everytime, how could we do otherwise ?
      user.update_reviews_from_upstream_notifications
      user.reviews
    end
  end
end
