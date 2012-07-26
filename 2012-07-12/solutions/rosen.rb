def collection_from_string(songs_as_string, artist_tags)
  # array of hashes for all songs
  songs_array = []
  songs_as_string.each_line do |song|
    song_line = song.split('.')

    # get all the song properties
    name = song_line[0]
    artist =  song_line[1].strip
    genres_list = song_line[2].strip.split(', ')
    genre = genres_list.shift.downcase
    subgenre = genres_list.shift
    subgenre = subgenre.downcase unless subgenre.nil?
    tags = []
    if song_line[3].nil?
      tags << genre
      tags << subgenre unless subgenre.nil?
    else
      tags = song_line[3].strip.split(', ')
      tags << genre
      tags << subgenre unless subgenre.nil?
    end

    # additional tags from the artist_tags hash
    artist_tags.each do |k, v|
      if k == artist
        tags.concat(v)
      end
    end unless artist_tags.nil?

    # create hash and put it in the array in poisition i
    song_hash = {name: name, artist: artist, genre: genre, subgenre: subgenre, tags: tags}
    songs_array << song_hash
  end
  songs_array
end
def find_in_collection(collection, criteria)
  matching_songs = []
  # convert to a usable format
  # incorporate artist_tags here or have a converted collection
  # collection = collection_from_string(collection, nil)
  # filter handling
  if criteria.has_key?(:filter)
    lambda_filter = criteria[:filter]
    # puts lambda_filter.call(collection[0])
  end

  # for every key in the criteria
  # too many loops here

  criteria.each do |criteria_key, criteria_value|
    # loop through the collection and check if the key matches
    collection.each do |song|
      if (lambda_filter.call(song) unless lambda_filter.nil?)
        lambda_check = true
        matching_songs << song
      else
        lambda_check = false
      end

      # use lambda_check when we have more than one criteria?
      # puts lambda_filter.call(song)
      song.select do |k,v|
        if criteria_key == k
          # puts "#{criteria_value} asdf #{v}"
          # weird check - if the length of the intersection is equal to the length of the criteria value => they are the same
          if (v & criteria_value).length == criteria_value.length
            matching_songs << song
            # puts lambda_filter.call(song) unless lambda_filter.nil?
          end
        end
      end
    end
  end
  matching_songs
end
