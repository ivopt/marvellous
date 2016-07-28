require 'rails_helper'

# because the Marvelite client injects the `ts` param into every request
# this breaks VCR, so a "quick-and-dirty" way to workaround this is this
# (another one would be to isolate this on a refinement and use it here)
module Marvelite
  module API
    class Client
      def ts
        123
      end
    end
  end
end

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
