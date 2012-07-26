def collection_from_string(songs_as_string, artist_tags)
  result = []

  songs_as_string.strip.split("\n").each do |line|
    title, artist, genre, tags = line.split('.').map(&:strip)
    genre, subgenre = genre.split(',').map(&:strip)

    tags ||= ''
    tags = tags.split(',').map(&:strip).map(&:downcase)
    tags << genre.downcase
    tags << subgenre.downcase if subgenre

    if artist_tags[artist]
      tags = tags + artist_tags[artist]
    end

    result << {name: title, artist: artist, genre: genre, subgenre: subgenre, tags: tags}
  end

  result
end


def find_in_collection(collection, criteria)
  collection.select do |song|
    result = true

    criteria.each do |k, v|
      case k
      when :tags then
        if not v.is_a?(Array)
          v = [v]
        end

        v.each do |tag|
          if tag.end_with?('!')
            result = false if song[:tags].include?(tag.chop)
          else
            result = false if not song[:tags].include?(tag)
          end
        end
      when :name then
        result = false if song[:name] != v
      when :artist then
        result = false if song[:artist] != v
      when :genre then
        result = false if song[:genre] != v
      when :subgenre then
        result = false if song[:genre] != v
      when :filter then
        result = v.call(song)
      end

      break if not result
    end

    result
  end
end
