class ComicsRepository
  # PER_PAGE = 15
  attr_reader :marvel_client

  def initialize(marvel_client = MarvelAPI.client)
    @marvel_client = marvel_client
  end

  def comics(page: nil, per: nil)
    opts = {
      # default order: from recent to old (by publishing date)
      orderBy: '-onsaleDate'
    }

    if page && per
      opts[:limit]  = per
      opts[:offset] = (page - 1) * per
    end

    # if only we had the |> operator...
    map_results_to_models( marvel_client.comics(opts) )
  end

  private

  def map_results_to_models(data)
    data[:data][:results].map &method(:map_to_model)
  end

  def map_to_model(comic_hash)
    Comic.new(
      id: comic_hash[:id],
      title: comic_hash[:title],
      thumbnail_path: "#{comic_hash[:thumbnail][:path]}.#{comic_hash[:thumbnail][:extension]}",
      date: comic_hash[:dates].find{|d| d[:type] == 'onsaleDate'}[:date]
    )
  end
end
