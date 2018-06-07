require('pg')
require_relative('../db/sql_runner.rb')

class Artist
  attr_accessor :name
  attr_reader :id

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
    @id = result[0]['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM artists"
    artists = SqlRunner.run(sql)
    return artists.map { |person| Artist.new(person)}
  end

  def albums()
    values = [@id]
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    albums = SqlRunner.run(sql, values)
    return albums.map { |record| Album.new(record) }
  end

  def delete_artist()
    values = [@artist_id]
    sql = "DELETE FROM artists WHERE id = $1"
    SqlRunner.run(sql, values)
  end

  def update_artist()
    values = ["Lou Reed"]
    sql = "UPDATE artists SET name = $1"
    SqlRunner.run(sql, values)
  end

  def self.find_by_id(id)
    values = [id]
    sql = "SELECT * FROM artists WHERE id = $1"
    artist = SqlRunner.run(sql, values)
    return artist.map { |person| Artist.new(person)}
  end

end
