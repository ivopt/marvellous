class ListComics
  PER_PAGE = 15
  MAX_CHARACTERS_PER_SEARCH = 10

  def self.call(*args)
    new.call(*args)
  end

  attr_reader :comics_repository, :characters_repository

  def initialize(comics_repository: ComicsRepository.new,
                 characters_repository: CharactersRepository.new)
    @comics_repository = comics_repository
    @characters_repository = characters_repository
  end

  def call(page: 1, search_form: nil, success: ->{}, failure: ->{})
    opts = {}

    add_pagination_to(opts, page)
    add_filter_to(opts, search_form)

    comics = comics_repository.comics(opts)

    mark_favourites(comics)

    success.call(comics)
  rescue
    failure.call
  end

  private

  def add_filter_to(opts, search_form)
    return opts unless search_form
    return opts unless search_form.character

    name = search_form.character.strip
    return opts if name.empty?

    characters = characters_repository.characters(name: name)

    opts[:characters] = characters.take(MAX_CHARACTERS_PER_SEARCH)
                                  .map(&:id)
  end

  def add_pagination_to(opts, page)
    opts[:page] = page
    opts[:per] = PER_PAGE
  end

  def mark_favourites(comics)
    ids = comics.map(&:id)
    favourites = FavouriteComic.favourites(ids)
    comics.select { |comic| favourites.include? comic.id }
          .each { |comic| comic.favourite = true }
  end

end
