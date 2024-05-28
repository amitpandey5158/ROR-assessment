require 'rails_helper'

RSpec.describe NewsController, type: :controller do
  let(:user) { create(:user) }

  before do
    sign_in user
    allow(NewsApi).to receive(:fetch_top_headlines).and_return([{ title: 'Sample News' }])
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get :show
      expect(response).to be_successful
    end

    it 'assigns @articles' do
      get :show
      expect(assigns(:articles)).to eq([{ title: 'Sample News' }])
    end

  end
end
