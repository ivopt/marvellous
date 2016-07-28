require 'rails_helper'

describe "comics/index.html", type: :view do

  it 'renders a collection of comics' do
    render(template: 'comics/index.html.haml',
           locals: {
             comics: [
               build(:comic), build(:comic), build(:comic)
             ],
             page: 1
           })
    expect(rendered).to have_css('.comic', count: 3)
  end

end
