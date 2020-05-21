require("pry")
require('pg')
require_relative('../db/sql_runner')

class Artist

  attr_accessor :id, :first_name, :last_name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
  end


def albums()
  sql = "SELECT * FROM albums WHERE artist_id = $1"
  values = [@id]
  results = SqlRunner.run(sql, values)
  albums = results.map {|album| Album.new(album)}
  return albums
end

def save()
  sql = "INSERT INTO artists
    (
    first_name,
    last_name
    ) VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@first_name, @last_name]
    returned_array = SqlRunner.run(sql, values)
    artist_hash = returned_array[0]
    @id = artist_hash['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM artists"
    artists = SqlRunner.run(sql)
    return artists.map{|artist| Artist.new(artist)}
  end

  def self.find(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    artist_hash = results.first
    artist = Artist.new(artist_hash)
    return artist
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

end
