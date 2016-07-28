require 'rails_helper'

RSpec.describe ComicsController, type: :controller do

  describe 'GET #index' do
    before do
      subject.send(:load_list_comics_command, list_comics_cmd)
    end

    context 'when successfull' do
      let(:list_comics_cmd) {
        comics = [ build(:comic), build(:comic) ]
        ->(h) { (h[:success] || ->{}).call(comics) }
      }

      it 'returns 200 OK' do
        get :index
        expect(response).to have_http_status(:success)
      end

      it 'renders the index template' do
        get :index
        expect(subject).to render_template(:index)
      end
    end

    context 'when unsuccessfull' do
      let(:list_comics_cmd) {
        ->(h) { (h[:failure] || ->{}).call }
      }

      it 'returns 404' do
        get :index
        expect(response).to have_http_status(500)
      end
    end
  end

end
