require 'rails_helper'
require 'support/marvelite_hack'

describe 'Listing comics', :vcr, type: :feature do

  context 'when landing on the homepage' do
    before do
      visit '/'
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

  describe 'pagination' do
    context 'when landing on the first page' do
      before { visit '/?page=1' }

      it 'displays the Next Page link' do
        expect(page).to have_content('Next Page')
      end

      it 'does not display the Previous Page link' do
        expect(page).not_to have_content('Previous Page')
      end
    end

    context 'when landing on another page' do
      before { visit '/?page=2' }

      it 'displays the Next Page link' do
        expect(page).to have_content('Next Page')
      end

      it 'displays the Previous Page link' do
        expect(page).to have_content('Previous Page')
      end
    end
  end

  describe 'search by character' do
    # This tests are kind of flaky as they depend on this character
    # that only has 3 comics...
    before { visit '/?search_form[character]=Lorna' }

    it 'displays only the comics for the given character' do
      expect(page).to have_css('.comic', count: 3)
    end

    it 'pagination links preserve the search form' do
      expect(page).to have_link('Next Page', :href => /Lorna/)
    end
  end
end
