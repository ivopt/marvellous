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
      dates = page.all('.date').map(&:text)
      dates.each_cons(2) do |date1, date2|
        expect(date1.to_date).to be >= date2.to_date
      end
    end
  end

end
