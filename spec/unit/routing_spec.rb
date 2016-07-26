require 'rails_helper'

describe 'routes', type: :routing do
  it 'routes the homepage to comic#index' do
    expect(get: '/').to route_to(controller: 'comics', action: 'index')
  end
end
