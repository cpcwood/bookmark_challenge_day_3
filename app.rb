require 'sinatra/base'
require_relative './lib/bookmarks'

class BookmarkManager < Sinatra::Base
  # Environment
  # --------------------

  # Allow html forms to provide put requests
  use Rack::MethodOverride

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

  delete '/bookmarks/:id' do
    Bookmark.delete(params[:id])
    redirect('/bookmarks')
  end

  put '/bookmarks/:id' do
    Bookmark.update(params[:id], params[:url], params[:title])
    redirect('/bookmarks')
  end

  #--------------------

  run! if __FILE__ == $0
end
