require 'pg'

class Bookmark

  # Instance
  # --------------------

  attr_reader :title, :url

  def initialize(database_object)
    @title = database_object['title']
    @url = database_object['url']
  end


  # Class
  # --------------------

  def self.all
    con = self.connect
    begin
      rs = con.exec "SELECT * FROM bookmarks"
      list = []
      rs.each {|row| list << self.new(row)}
    rescue => e
      puts e.message
    ensure
      rs.clear if rs
      con.close if con
    end
    list
  end

  def self.add(url, title)
    con = self.connect
    begin
      con.exec("INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}')")
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
