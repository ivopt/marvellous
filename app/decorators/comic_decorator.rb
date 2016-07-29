class ComicDecorator < SimpleDelegator

  def self.wrap(collection)
    collection.map { |comic| self.new(comic) }
  end

  def class
    __getobj__.class
  end

  def title
    # remove year and issue number if they exist
    super.gsub(/\(\d{4}\) *#\d+$/, '').strip
  end

  def issue_number
    "##{super}"
  end

end
