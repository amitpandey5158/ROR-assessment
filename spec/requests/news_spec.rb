require 'rails_helper'
require 'webmock/rspec'

RSpec.describe NewsApi, type: :service do
  before do
    stub_request(:get, /newsapi.org/).to_return(
      body: { articles: [{ title: 'Sample News' }] }.to_json,
      headers: { 'Content-Type' => 'application/json' }
    )
  end

  describe '.fetch_top_headlines' do
    it 'returns articles if the request is successful' do
      articles = NewsApi.fetch_top_headlines
      expect(articles).not_to be_nil
      expect(articles.first['title']).to eq('Sample News')
    end

    it 'returns nil if the request fails' do
      stub_request(:get, /newsapi.org/).to_return(status: 500)
      articles = NewsApi.fetch_top_headlines
      expect(articles).to be_nil
    end
  end
end
