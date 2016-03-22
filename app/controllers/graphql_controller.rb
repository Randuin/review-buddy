class GraphqlController < ApplicationController
  before_action :authenticate_user_from_token!

  def create
    query_string = params[:query]
    query_variables = params[:variables] || {}
    result = Schema.execute(
      query_string,
      variables: query_variables,
      context: { current_user: current_user }
    )
    render json: result
  end
end
