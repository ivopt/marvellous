require 'rails_helper'
require 'support/marvelite_hack'

describe ComicsRepository, :vcr do
  context 'when fetching comics' do
    let(:per) { 20 }

    it 'fetches as much comics as the per page limit' do
      expect(
        subject.comics(page: 1, per: per).length
      ).to eq per
    end

    it 'results are ordered by date' do
      comics = subject.comics(page: 1, per: 10)
      comics.each_cons(2) { |comic1, comic2|
        expect(comic1.date).to be >= comic2.date
      }
    end
  end
end
