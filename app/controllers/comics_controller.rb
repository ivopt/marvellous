class ComicsController < ApplicationController

  def index
    render(:index, locals: {
      comics: [
        Comic.new(id: 42882, title: 'Lorna the Jungle Girl (1954) #6', thumbnail_path: 'http://i.annihil.us/u/prod/marvel/i/mg/9/40/50b4fc783d30f.jpg'),
        Comic.new(id: 41530, title: 'Ant-Man: So (Trade Paperback)', thumbnail_path: 'http://i.annihil.us/u/prod/marvel/i/mg/c/30/4fe8cb51f32e0.jpg'),
        Comic.new(id: 43092, title: 'Brilliant (2011) #7', thumbnail_path: 'http://i.annihil.us/u/prod/marvel/i/mg/b/80/4fb2a4aa018c6.jpg'),
      ]
    })
  end

end
