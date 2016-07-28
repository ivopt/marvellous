require 'rails_helper'

describe "shared/search_form.html.haml", type: :view do

  let(:search_form) { SearchForm.new }

  before do
    render(template: 'shared/_search_form.html.haml', locals: {search_form: search_form})
  end

  it 'renders the search form' do
    expect(rendered).to have_css('form')
    expect(rendered).to have_css('input[name="search_form[character]"]')
    expect(rendered).to have_css('input[placeholder="Search by character..."]')
  end

end
