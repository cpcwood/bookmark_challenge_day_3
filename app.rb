require 'sinatra/base'
require_relative './lib/bookmarks'

class BookmarkManager < Sinatra::Base

  # Routes
  # --------------------

  get '/' do
    erb :homepage
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :list_bookmarks
  end

  post '/bookmarks' do
    Bookmark.add(params[:url], params[:title])
    redirect('/bookmarks')
  end

  #--------------------

  run! if __FILE__ == $0
end
