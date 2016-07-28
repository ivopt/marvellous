class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_search_form

  private

  def set_search_form
    @search_form = SearchForm.new(search_form_params)
  end

  def search_form_params
    params.permit(search_form: [:character])[:search_form]
  end

end
