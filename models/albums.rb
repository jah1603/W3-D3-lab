require('pg')
require_relative('../db/sql_runner.rb')

class Artist
  attr_accessor :title, :artist_id, :genre
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    # @artist_id
    @genre = options['genre']
  end

  def save()
    sql = "INSERT INTO artists
    (
      title
      artist_id
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
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM artists"
    artists = SqlRunner.run(sql)
    return artists.map { |person| artist.new(person)}
  end

end
