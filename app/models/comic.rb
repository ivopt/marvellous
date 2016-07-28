class Comic
  attr_accessor :id,
                :title,
                :thumbnail_path,
                :date,
                :issue_number

  def initialize(id: nil,
                 title: nil,
                 thumbnail_path: nil,
                 date: '',
                 issue_number: nil)
    @id             = id
    @title          = title
    @thumbnail_path = thumbnail_path
    @date           = date.to_date # this is based on the assumption date will never be nil!
    @issue_number   = issue_number
  end

  def year
    date.year
  end
end
