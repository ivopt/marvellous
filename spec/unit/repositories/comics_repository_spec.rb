require 'spec_helper'

describe ComicsRepository do

  def new_comic(id)
    # TODO: move this method to its own factory..
    {
      id: id,
      title: "Comic #{id}",
      thumbnail: {path: "http://example.com/comic_#{id}", extension: 'jpg'},
      dates: [
        {type: 'onsaleDate', date: "2016-01-0#{id}T00:00:00"}
      ]
    }
  end

  let(:comic1) { new_comic(1) }
  let(:comic2) { new_comic(2) }
  let(:marvel_client) {
    double('MarvelClient', comics: { data: { results: [comic1, comic2] } })
  }

  subject { described_class.new(marvel_client) }

  describe '.comics' do
    it 'invokes the client `comics` method' do
      expect(marvel_client).to receive(:comics)
      subject.comics
    end

    it 'translates `page` and `per` arguments into marvel API arguments' do
      args = {page: 2, per: 10}

      expect(marvel_client).to receive(:comics).with(hash_including(limit: 10, offset: 10))
      subject.comics(args)
    end

    it 'returns a collection of the same length as the marvel_client result list' do
      expect(
        subject.comics.length
      ).to eq(marvel_client.comics[:data][:results].length)
    end

    it 'maps results to Comic model instances' do
      comics = subject.comics
      expect(comics).to all(be_kind_of(Comic))
      expect(comics.first.id).to eq comic1[:id]
      expect(comics.first.title).to eq comic1[:title]
      expect(comics.first.thumbnail_path).to eq "#{comic1[:thumbnail][:path]}.#{comic1[:thumbnail][:extension]}"
      expect(comics.first.date).to eq comic1[:dates][0][:date].to_date
    end
  end

end
