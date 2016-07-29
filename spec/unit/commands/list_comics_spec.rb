require 'spec_helper'

describe ListComics do

  let(:comic1) { build(:comic) }
  let(:comic2) { build(:comic) }
  let(:comics_repo) { double('ComicsRepository', comics: [comic1, comic2]) }
  let(:chars_repo) { double('CharactersRepository') }

  subject {
    described_class.new(comics_repository: comics_repo,
                        characters_repository: chars_repo)
  }

  describe '.call' do
    it 'calls to the repository#comics method' do
      expect(comics_repo).to receive(:comics)
      subject.call
    end

    it 'relays the page parameter to the repository#comics method call' do
      page = 10
      expect(comics_repo).to(
        receive(:comics).with(hash_including(page: page))
      )
      subject.call(page: page)
    end

    it 'inject the `per page` param on the repository#comics method call' do
      expect(comics_repo).to(
        receive(:comics).with(hash_including(per: described_class::PER_PAGE))
      )
      subject.call
    end

    context 'when passed a search form with a character name' do
      let(:character_name) { 'spider' }
      let(:character1) { build(:character, name: "#{character_name} 1") }
      let(:character2) { build(:character, name: "#{character_name} 2") }
      let(:chars_repo) { double('CharactersRepository', characters: [character1, character2]) }

      it 'passes a list of character ids when calling to the comics repository' do
        search_form = OpenStruct.new(character: character_name)
        expect(comics_repo).to(
          receive(:comics).with hash_including(characters: chars_repo.characters.map(&:id))
        )
        subject.call(search_form: search_form)
      end

      shared_examples "ignores the search form when" do |reason, example|
        it "character #{reason}" do
          search_form = OpenStruct.new(character: example)
          expect(comics_repo).not_to(
            receive(:comics).with hash_including(characters: chars_repo.characters.map(&:id))
          )
          subject.call(search_form: search_form)
        end
      end

      it_behaves_like 'ignores the search form when', 'is nil', nil
      it_behaves_like 'ignores the search form when', 'is empty', ''
      it_behaves_like 'ignores the search form when', 'is only whitespace', '   '
    end

    context 'on successful call to repository' do
      it 'calls the success callback with the comics returned from the repo' do
        success = double('success', call: nil)
        expect(success).to receive(:call).with(comics_repo.comics)
        subject.call(success: success)
      end
    end

    context 'on failure to call to repository' do
      it 'calls the failure callback' do
        allow(comics_repo).to receive(:comics).and_raise('random_error')
        failure = double('failure', call: nil)
        expect(failure).to receive(:call)
        subject.call(failure: failure)
      end
    end

    context 'regarding favourite comics' do
      before { create(:favourite_comic, comic_id: comic1.id) }

      it 'it marks favourite comics as being favourite' do
        expect(comic1).to receive(:favourite=).with(true)
        expect(comic2).not_to receive(:favourite=).with(true)
        subject.call
      end
    end
  end
end
