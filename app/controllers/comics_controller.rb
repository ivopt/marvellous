class ComicsController < ApplicationController
  before_action :load_list_comics_command

  def index
    page = (params[:page] || 1).to_i

    list_command.call(
      page: page,
      search_form: @search_form,
      success: ->(comics) {
        decorated_comics = ComicDecorator.wrap(comics)
        render(:index, locals: { comics: decorated_comics, page: page })
      },
      failure: ->{
        render template: 'errors/unknown', status: 500
      }
    )
  end

  private

  # This is a sort-of Dependency Injection (since we cannot use the constructor... rails shennanigans)
  attr_reader :list_command
  def load_list_comics_command(list_comics = ListComics)
    @list_command ||= list_comics
  end

end
