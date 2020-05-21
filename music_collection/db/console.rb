require("pry")
require_relative("../models/album")
require_relative("../models/artist")

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({'first_name' => 'Aphex', 'last_name' => 'Twin'})
artist1.save()

album1 = Album.new({
  'album_title' => 'Windowlicker',
  'genre' => 'Electronic',
  'artist_id' => artist1.id})
album1.save()

artist1.albums()
album1.artist()

artist2 = Artist.new({
  'first_name' => 'Squarepusher',
  'last_name' => '',
  })
artist2.save()

album2 = Album.new({
  'album_title' => 'Feed Me Weird Things',
  'genre' => 'Drum \'n Bass',
  'artist_id' => artist2.id})
album2.save()

binding.pry
nil
