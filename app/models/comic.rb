class Comic
  attr_accessor :id, :title, :thumbnail_path, :date

  def initialize(id: nil, title: nil, thumbnail_path: nil, date: '')
    @id             = id
    @title          = title
    @thumbnail_path = thumbnail_path
    @date           = date.to_date # this is based on the assumption date will never be nil!
  end
end
