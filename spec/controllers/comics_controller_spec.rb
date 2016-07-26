require 'rails_helper'

RSpec.describe ComicsController, type: :controller do

  context '#index' do
    it 'returns 200 OK' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
