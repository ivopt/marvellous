require 'rails_helper'

describe Comic, type: :model do
  describe '#year' do
    let(:date) { Date.parse('1983-09-25') }
    subject(:comic) { Comic.new(date: date) }

    it 'returns the year of the comic date' do
      expect(comic.year).to eq date.year
    end
  end
end
