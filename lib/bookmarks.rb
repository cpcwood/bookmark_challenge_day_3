require 'pg'

class Bookmark

  # Instance
  # --------------------

  attr_reader :title, :url, :id

  def initialize(database_object)
    @title = database_object['title']
    @url = database_object['url']
    @id = database_object['id']
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
    list.sort_by{|bookmark| bookmark.id}
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

  def self.update(id, url, title)
    con = self.connect
    begin
      con.exec("UPDATE bookmarks SET url = '#{url}', title = '#{title}' WHERE id = #{id}")
    rescue => e
      puts e.message
    ensure
      con.close if con
    end
  end

  def self.delete(id)
    con = self.connect
    begin
      con.exec("DELETE FROM bookmarks WHERE id = #{id}")
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

  private

  def self.valid_url?(url)
    url.match?(/\Ahttp{1}[s]?:\/\/w{3}\.[\w-]+\.[\w]{2,}\z/)
  end
end
