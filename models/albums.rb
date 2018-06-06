require('pg')
require_relative('../db/sql_runner.rb')

class Album
  attr_accessor :title, :artist_id, :genre
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @artist_id = options['artist_id'].to_i
    @genre = options['genre']
  end

  def save()
    sql = "INSERT INTO albums
    (
      title,
      artist_id,
      genre
    ) VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@title, @artist_id, @genre]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM albums"
    albums = SqlRunner.run(sql)
    return albums.map { |record| Album.new(record)}
  end

  def artist()
    sql = "SELECT * FROM artists WHERE
      id = $1"
    values = [@artist_id]
    artists = SqlRunner.run(sql, values).first
    return Artist.new(artists)
  end

  def delete_album()
    values = [@id]
    sql = "DELETE FROM albums WHERE id = $1"
    SqlRunner.run(sql, values)
  end

  def update_album()
    values = ["Diamond Dogs", "unclassifiable", @artist_id]
    sql = "UPDATE albums SET (title, genre, artist_id) = ($1, $2, $3)"
    SqlRunner.run(sql, values)
  end

end
