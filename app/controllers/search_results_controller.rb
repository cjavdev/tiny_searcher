class SearchResultsController < ApplicationController
  def index
    @search_service = Search.new(params.fetch(:query, ""))
    @results = @search_service.results
  end
end
