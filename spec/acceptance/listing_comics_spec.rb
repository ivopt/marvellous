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

    it 'displiays comics ordered from youngest to oldest' do
      years = page.all('.year').map(&:text)
      years.each_cons(2) do |year1, year2|
        expect(year1.to_i).to be >= year2.to_i
      end
    end
  end

end
