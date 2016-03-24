module Resolvers
  class Reviews
    def call(user, _, _)
      user.reviews
    end
  end
end
