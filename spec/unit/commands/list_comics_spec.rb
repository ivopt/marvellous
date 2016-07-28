require 'spec_helper'

describe ListComics do

  let(:comic1) { build(:comic) }
  let(:comic2) { build(:comic) }
  let(:comics_repo) { double('ComicsRepository', comics: [comic1, comic2]) }
  subject { described_class.new(comics_repository: comics_repo) }

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
  end
end
