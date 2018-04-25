require("pry")
require_relative("../models/artist")
require_relative("../models/album")
require_relative("../db/sql_runner")

artist1 = Artist.new({
  'name' => 'Hamish'
  })
#artist1.save()

artist2 = Artist.new({
  'name' => 'Luis'
  })
#artist2.save()

album1 = Album.new({
  'artist_id' => artist1.id,
  'name' => 'Wonderwall',
  'genre' => 'rock'
  })

  #album1.save()

binding.pry
nil
