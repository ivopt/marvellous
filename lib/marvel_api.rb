require 'marvelite'

class MarvelAPI
  def self.client
    Marvelite::API::Client.new(
      public_key:  ENV!['MARVEL_API_PUBLIC_KEY'],
      private_key: ENV!['MARVEL_API_SECRET_KEY']
    )
  end
end

