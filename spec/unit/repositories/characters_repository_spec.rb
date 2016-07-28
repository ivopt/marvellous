require 'spec_helper'

describe CharactersRepository do

  def new_character(id)
    {
      id: id,
      name: "Character #{id}"
    }
  end

  let(:character1) { new_character(1) }
  let(:character2) { new_character(2) }
  let(:marvel_client) {
    double('MarvelClient', characters: { data: { results: [character1, character2] } })
  }

  subject { described_class.new(marvel_client) }

  describe '.characters' do
    it 'invokes the client `characters` method' do
      expect(marvel_client).to receive(:characters)
      subject.characters
    end

    it 'returns a list of Character model instances' do
      characters = subject.characters
      expect(characters).to all(be_kind_of(Character))
      expect(characters.first.id).to eq character1[:id]
      expect(characters.first.name).to eq character1[:name]
    end

    it 'translates `name` argument into marvel API nameStartsWith argument' do
      name = 'spider'
      expect(marvel_client).to receive(:characters).with(hash_including(nameStartsWith: name))
      subject.characters(name: name)
    end

    it 'returns a collection of the same length as the marvel_client result list' do
      expect(
        subject.characters.length
      ).to eq(marvel_client.characters[:data][:results].length)
    end
  end

end
