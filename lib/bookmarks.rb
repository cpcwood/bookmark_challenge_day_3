require 'pg'

class Bookmark

  def self.all
    con = self.connect
    begin
      rs = con.exec "SELECT * FROM bookmarks"
      list = []
      rs.each {|row| list << row['url']}
    rescue => e
      puts e.message
    ensure
      rs.clear if rs
      con.close if con
    end
    list
  end

  def self.add(url)
    con = self.connect
    begin
      con.exec("INSERT INTO bookmarks (url) VALUES('#{url}')")
    rescue => e
      puts e.message
    ensure
      con.close if con
    end
  end

  def self.custom_command(command)
    con = self.connect
    begin
      con.exec(command)
    rescue => e
      puts e.message
    ensure
      con.close if con
    end
  end

  def self.connect
    database = (ENV['ENVIRONMENT'] == 'test' ? 'bookmark_manager_test' : 'bookmark_manager')
    PG.connect(:dbname => database, :user => ENV['USER'])
  end

end
