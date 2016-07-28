class ListComics
  PER_PAGE = 15

  def self.call(*args)
    new.call(*args)
  end

  attr_reader :comics_repository

  def initialize(comics_repository: ComicsRepository.new)
    @comics_repository = comics_repository
  end

  def call(page: 1, success: ->{}, failure: ->{})
    comics = comics_repository.comics(page: page, per: PER_PAGE)
    success.call(comics)
  rescue
    failure.call
  end

end
