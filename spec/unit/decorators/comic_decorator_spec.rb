require 'spec_helper'

describe ComicDecorator do

  describe '.wrap' do
    subject { described_class }
    let(:comics) { [build(:comic), build(:comic)] }

    it 'wraps a collection of object with this decorator' do
      decorated_comics = subject.wrap(comics)
      decorated_comics.each do |comic|
        expect(comic).to be_a ComicDecorator
      end
    end
  end

  describe '#title' do
    subject { described_class.new(comic) }

    context 'when title has both year and issue number' do
      let(:comic) { build(:comic, title: 'hello world (2016) #1') }

      it 'removes both the year and issue number' do
        expect(subject.title).to eq('hello world')
      end
    end

    context 'when title is missing year or issue number' do
      let(:comic) { build(:comic, title: 'hello world (2016)') }

      it 'just returns the title unchanged' do
        expect(subject.title).to eq(comic.title)
      end
    end
  end

  describe '#issue_number' do
    let(:comic) { build(:comic, issue_number: 10) }
    subject { described_class.new(comic) }

    it 'prepends a # sign to the issue number' do
      expect(subject.issue_number).to eq("##{comic.issue_number}")
    end
  end

end
