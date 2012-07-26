def collection_from_string(songs_as_string, artist_tags)
  songs_as_string.split("\n").map do |line|
    song_hash = {}
    line = line.squeeze(' ').split('.')

    song_hash[:name] = line[0].strip
    song_hash[:artist] = line[1].strip
    song_hash[:genre], song_hash[:subgenre] = line[2].strip.split(', ')
    song_hash[:tags] = line[3].to_s.strip.split(', ')

    song_hash[:tags] += artist_tags[song_hash[:artist]].to_a

    song_hash[:tags] << song_hash[:genre].downcase
    song_hash[:tags] << song_hash[:subgenre].downcase unless song_hash[:subgenre].nil?

    song_hash[:tags] = song_hash[:tags].uniq

    song_hash
  end
end

def is_criteria_fulfilled(song, criteria)
  criteria.all? do |song_attribute, value|
    if song_attribute == :filter
      value.call(song)
    elsif song_attribute == :tags
      tags = Array(value)
      tags.all? do |tag|
        if tag.end_with?('!')
          !song[:tags].include? tag.chop
        else
          song[:tags].include? tag
        end
      end
    else
      song[song_attribute] == value
    end
  end
end

def find_in_collection(collection, criteria)
  collection.select do |song|
    is_criteria_fulfilled(song, criteria)
  end
end
