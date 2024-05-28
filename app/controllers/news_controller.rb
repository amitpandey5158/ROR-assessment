# app/controllers/news_controller.rb
class NewsController < ApplicationController
  def show
    @articles = NewsApi.fetch_top_headlines
  end
end
