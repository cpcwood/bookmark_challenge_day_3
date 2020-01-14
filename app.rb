require 'pg'
require 'sinatra/base'
require_relative './lib/bookmarks'

class BookmarkManager < Sinatra::Base
  get '/' do
    'Bookmark Manager'
  end

  get '/bookmarks' do
    con = PG.connect(:dbname => 'bookmark_manager', :user => ENV['USER'])

    Bookmark.add_connection(con)

    @bookmarks = Bookmark.all
    erb :'bookmarks/index'
  end



  run! if app_file == $0
end
