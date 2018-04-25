require('pg')
require_relative("../db/sql_runner")
require_relative("artist")

class Album

  attr_accessor :name, :genre
  attr_reader :id, :artist_id

  def initialize(options)
    @name = options['name']
    @genre = options['genre']
    @id = options['id'].to_i if options['id']
    @artist_id = options['artist_id'].to_i
  end

  def save()
    sql = "INSERT INTO albums
    (
      name,
      genre,
      artist_id
      ) VALUES
      (
        $1, $2, $3
      )
      RETURNING id"
      values = [@name, @genre, @artist_id]
      result = SqlRunner.run(sql, values)
      @id = result[0]["id"].to_i
    end

    def update()
      sql = "
      UPDATE albums SET (
        name,
        genre,
        artist_id
        ) =
        (
          $1, $2, $3
        )
        WHERE id = $4"
        values = [@name, @genre, @artist_id, @id]
        db = SqlRunner.run(sql, values)
      end

      def delete()
        sql = "DELETE FROM albums WHERE id = $1"
        values = [@id]
        db = SqlRunner.run(sql, values)
      end

    # CLASS METHODS

    def self.all()
      sql = "SELECT * FROM albums"
      albums = SqlRunner.run(sql)
      albums_array = albums.map { |album| Album.new(album)}
      return albums_array
    end

    def self.find(id)
      sql = "SELECT * FROM albums WHERE artist_id = $1"
      values = [id]
      results = SqlRunner.run(sql, values)
      album_hash = results.first
      order = Album.new(album_hash)
      return order
    end

end
