require('pry')
require_relative('../models/artists.rb')
require_relative('../models/albums.rb')

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({
  "name" => "David Bowie"
  })
  artist1.save()

album1 = Album.new({
  "title" => "Hunky Dory",
  "genre" => "several",
  "artist_id" => artist1.id()
  })
  album1.save()

  artist1.albums()

binding.pry
nil
