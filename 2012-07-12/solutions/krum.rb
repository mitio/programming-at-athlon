def collection_from_string(input_string, artist_tags)
  collection = []
  input_string.lines do |line|
    song = line.chomp.strip.split(/ *\. */)
    song[2] = song[2].split(/ *, */)
    song[2].insert(1, nil) if song[2].length < 2
    song = Hash[[:name, :artist, :genre, :subgenre, :tags].zip(song.flatten)]
    original_tags = Array(song[:tags].to_s.split(/ *, */))
    genre_tag     = Array(song[:genre].to_s.downcase)
    subgenre_tag  = Array(song[:subgenre].to_s.downcase)
    tags_from_artist = Array(artist_tags[song[:artist]])
    song[:tags] = (original_tags|genre_tag|subgenre_tag|tags_from_artist).flatten.reject { |i| i == "" }
    collection << song
  end
  collection
end

def find_in_collection(collection, criteria)
  collection.select do |song|
    criteria.each do |key, criterion|
      if key == :filter
        result = criterion.call(song)
      else
        include = Array(criterion).select { |i| i[-1] != '!' }
        exclude = Array(criterion).select { |i| i[-1] == '!' }.map(&:chop)
        result = (Array(song[key]) & include == include) && (Array(song[key]) - exclude) == Array(song[key])
      end
      break unless result
    end
  end
end
