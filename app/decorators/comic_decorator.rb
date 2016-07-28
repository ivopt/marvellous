class ComicDecorator < SimpleDelegator

  def self.wrap(collection)
    collection.map { |comic| self.new(comic) }
  end

  def title
    # remove year and issue number if they exist
    super.gsub(/\(\d{4}\) *#\d+$/, '').strip
  end

end
