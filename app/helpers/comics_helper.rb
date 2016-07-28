module ComicsHelper

  def previous_page_link(page)
    if page > 1
      link_to('Previous Page', request.parameters.merge(page: page - 1))
    end
  end

  def next_page_link(page)
    link_to('Next Page', request.parameters.merge(page: page + 1))
  end

end
