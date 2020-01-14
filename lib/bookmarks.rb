require 'pg'
class Bookmark

  def self.all

    begin
        con = PG.connect :dbname => 'bookmark_manager', :user => ENV['USER']
        rs = con.exec "SELECT * FROM bookmarks"
        list = []
        rs.each {|row| list << row['url']}

    rescue PG::Error => e
        puts e.message
    ensure
        rs.clear if rs
        con.close if con
    end
    list
  end
end
