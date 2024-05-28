require 'httparty'

class NewsApi
  include HTTParty
  base_uri 'https://newsapi.org/v2'
  API_KEY = 'c718b6c91f0a4718a2e770743294a362'

  def self.fetch_top_headlines(country: 'us')
    response = get("/top-headlines?country=#{country}&apiKey=#{API_KEY}")
    return response.parsed_response['articles'] if response.success?
    nil
  end
end

