module Resolvers
  class Reviews
    def call(user, args, ctx)
      user.reviews
    end
  end
end
