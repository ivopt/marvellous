class Comic
  attr_accessor :id, :title, :thumbnail_path, :date

  def initialize(id: nil, title: nil, thumbnail_path: nil, date: nil)
    @id             = id
    @title          = title
    @thumbnail_path = thumbnail_path
    @date           = date
  end
end
