class Bookmark

  def self.add_connection(con)
    @@con = con
  end

  def self.all
    begin
        rs = @@con.exec "SELECT * FROM bookmarks"
        list = []
        rs.each {|row| list << row['url']}
    rescue => e
        puts e.message
    ensure
        rs.clear if rs
    end
    list
  end
end
