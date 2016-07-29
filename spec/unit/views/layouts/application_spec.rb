require 'rails_helper'

describe "layouts/application.html.haml", type: :view do

  before do
    @search_form = SearchForm.new
    render(template: 'layouts/application.html.haml')
  end

  it 'renders a header section' do
    expect(rendered).to have_css('header')
  end

  it 'renders a content section' do
    expect(rendered).to have_css('body .content')
  end

  context 'on the header section' do
    it 'renders a search by character form' do
      # TODO: add search functionality
      expect(rendered).to have_css('form input')
    end
  end

end
