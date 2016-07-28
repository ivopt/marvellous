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
