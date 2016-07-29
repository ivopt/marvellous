class FavouriteComic < ApplicationRecord

  def self.favourites(ids)
    where(comic_id: ids).pluck(:comic_id)
  end

  def self.toggle(comic_id)
    if exists?(comic_id: comic_id)
      delete_all(comic_id: comic_id)
    else
      create(comic_id: comic_id)
    end
  end

end
