require 'rails_helper'

describe FavouriteComic, type: :model do

  describe '.favourites' do
    subject { described_class }

    let(:comics) { [1,2,3,4] }
    before { create(:favourite_comic, comic_id: 1)
             create(:favourite_comic, comic_id: 2) }

    it 'returns the subset of comic_ids that are marked as favourites' do
      expect(subject.favourites(comics)).to match [1,2]
    end
  end

  describe '.toggle' do
    subject { described_class }

    context 'with an existing favourite' do
      before { create(:favourite_comic, comic_id: 1) }

      it 'deletes the favourite' do
        expect {
          subject.toggle(1)
        }.to change { FavouriteComic.count }.by(-1)
      end
    end

    context 'without an existing favourite' do
      it 'creates a new favourite' do
        expect {
          subject.toggle(1)
        }.to change { FavouriteComic.count }.by(1)
      end
    end

  end

end
