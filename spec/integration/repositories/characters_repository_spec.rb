require 'rails_helper'
require 'support/marvelite_hack'

describe CharactersRepository, :vcr do
  context 'when fetching characters with name filtering' do

    it 'only returns characters whos name matches the filter' do
      characters = subject.characters(name: 'spider')
      characters.each do |character|
        expect(character.name.downcase).to match(/spider/)
      end
    end

  end
end
