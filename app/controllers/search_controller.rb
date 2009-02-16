class SearchController < ApplicationController
  
  def index
    @results = ThinkingSphinx::Search.search params[:search]
  end
  
end
