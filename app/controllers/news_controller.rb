class NewsController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  def show
    @articles = NewsApi.fetch_top_headlines
  end
end
