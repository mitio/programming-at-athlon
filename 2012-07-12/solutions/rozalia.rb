def collection_from_string( songs_as_string, artist_tags )
  songs_as_string.split("\n").map do |line|
    {}.tap do |song|
      song[:tags] = []
      song[:name], song[:artist], genres, tags = line.split('.').map(&:strip)
      song[:genre], song[:subgenre] = genres.split(',').map(&:strip)
      song[:tags] = tags.split(',').map(&:strip) if tags

      song[:tags] += (artist_tags[song[:artist]]).uniq if artist_tags.has_key? song[:artist]

      song[:tags].push(song[:genre].downcase) if song[:genre]
      song[:tags].push(song[:subgenre].downcase) if song[:subgenre]
    end
  end
end

def find_in_collection( collection, criteria = {} )
  collection.select do |song|
    criteria.all? do |condition, value|
      if condition == :filter
        value.call(song)
      elsif condition == :tags
        Array(value).all? do |tag|
          (song[:tags].include? tag) || tag.end_with?('!') && !(song[:tags].include? tag.chop)
        end
      else
        song[condition] == value
      end
    end
  end
end
