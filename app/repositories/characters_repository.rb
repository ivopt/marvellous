class CharactersRepository
  attr_reader :marvel_client

  def initialize(marvel_client = MarvelAPI.client)
    @marvel_client = marvel_client
  end

  def characters(name: nil)
    opts = {}

    if name && !name.empty? # .blank? is rails, this is not rails...
      opts[:nameStartsWith] = name
    end

    map_results_to_models(marvel_client.characters(opts))
  end

  private

  def map_results_to_models(data)
    data[:data][:results].map &method(:map_to_model)
  end

  def map_to_model(character_hash)
    Character.new(
      id: character_hash[:id].to_i,
      name: character_hash[:name]
    )
  end

end
