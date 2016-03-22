class GraphqlController < ApplicationController
  def create
    query_string = params[:query]
    query_variables = params[:variables] || {}
    result = Schema.execute(
      query_string,
      variables: query_variablesm,
      context: { current_user: current_user }
    )
    render json: result
  end
end
