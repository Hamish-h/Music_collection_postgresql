require("pg")
require_relative("../db/sql_runner")
require_relative("album")

class Artist
  attr_reader :id, :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO artists
    (
      name
      ) VALUES
      (
        $1
      )
      RETURNING id"
      values = [@name]
      result = SqlRunner.run(sql, values)
      @id = result[0]["id"].to_i
    end

    def albums()
      sql= "SELECT * FROM albums WHERE artist_id = $1"
      values = [@id]
      results = SqlRunner.run(sql, values)
      orders = results.map { |album| Album.new(album)}
      return orders
    end

    def update()
      sql = "
      UPDATE artists SET (
        name
        ) =
        (
          $1
        )
        WHERE id = $2"
        values = [@name, @id]
        db = SqlRunner.run(sql, values)
      end

      def delete()
        sql = "DELETE FROM artists WHERE id = $1"
        values = [@id]
        db = SqlRunner.run(sql, values)
      end

    # CLASS METHODS

    def self.all()
      sql = "SELECT * FROM artists"
      artists = SqlRunner.run(sql)
      artists_array = artists.map { |artist| Artist.new(artist)}
      return artists_array
    end

  end
