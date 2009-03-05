class SearchController < ApplicationController
  
  def index
    @results = ThinkingSphinx::Search.search params[:search], :page => params[:page], :per_page => 10
  end
  
end
