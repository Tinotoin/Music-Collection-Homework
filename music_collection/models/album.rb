require('pg')
require_relative('../db/sql_runner')

class Album

  attr_accessor :album_title, :genre, :artist_id
  attr_reader :id

  def initialize(options)
    @album_title = options['album_title']
    @genre = options['genre']
    @id = options['id'].to_i if options['id']
    @artist_id = options['artist_id'].to_i
  end

  def artist()
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    results = SqlRunner.run(sql, values)
    artists = results.map {|artist| Artist.new(artist)}
    return artists
  end

  def save()
    sql = "INSERT INTO albums
      (
      album_title,
      genre,
      artist_id)
      VALUES
      (
        $1, $2, $3
      )
      RETURNING id"

      values = [@album_title, @genre, @artist_id]
      results = SqlRunner.run(sql, values)
      album_hash = results[0]
      @id = album_hash['id'].to_i
    end

    def self.all()
      sql = "SELECT * FROM albums"
      albums = SqlRunner.run(sql)
      return albums.map{|album| Album.new(album)}
    end

    def self.delete_all()
      sql = "DELETE FROM albums"
      SqlRunner.run(sql)
    end

end
