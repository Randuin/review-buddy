class GraphqlController < ApplicationController
  before_action :authenticate_user_from_token!

  def create
    query_string = params[:query]
    query_variables = params[:variables] || {}
    result = Schema.execute(
      query_string,
      variables: query_variables,
      context: { current_user: current_user },
      debug: true
    )
    puts result
    render json: result
  end

  def introspection
    result = Schema.execute(
      GraphQL::Introspection::INTROSPECTION_QUERY,
      debug:true
    )
    render json: result
  end
end
