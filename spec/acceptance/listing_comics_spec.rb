require 'rails_helper'

describe 'Listing comics', type: :feature do

  context 'when landing on the homepage' do
    before do
      VCR.use_cassette('homepage') do
        visit '/'
      end
    end

    it 'displays a paginated list of comics' do
      expect(page).to have_css('.comic', count: 15)
      expect(page).to have_content('Next Page')
    end

    xit 'displays comics ordered from youngest to oldest' do
      # TODO: find a way to check order
    end
  end

end
