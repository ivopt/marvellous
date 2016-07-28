require 'rails_helper'

describe "layouts/application.html.haml", type: :view do

  before do
    render(template: 'layouts/application.html.haml')
  end

  it 'renders a header section' do
    expect(rendered).to have_css('header')
  end

  context 'on the header section' do
    xit 'renders a search by character form' do
      # TODO: add search functionality
    end
  end

end
