def collection_from_string songs_as_string, artist_tags
  songs_as_string.split("\n").map do |line|
    {}.tap do |song|
      song[:tags] = []
      song[:name], song[:artist], genres, tags = line.split('.').map(&:strip)
      song[:genre], song[:subgenre] = genres.split(',').map(&:strip)
      song[:tags] = tags.split(',').map(&:strip) if tags

      # Merge the artist tags to the song tags
      song[:tags] = (song[:tags] + artist_tags[song[:artist]]).uniq if artist_tags.has_key? song[:artist]

      # Add the genre and the subgenre as tags
      song[:tags] << song[:genre].downcase if song[:genre]
      song[:tags] << song[:subgenre].downcase if song[:subgenre]
    end
  end
end

def find_in_collection collection, criteria = {}
   results = collection

   # Match for tags
   if criteria[:tags]
     results.select! do |song|
       match = true
       search_tags = []

       # Normalize the tags criteria
       if criteria[:tags].is_a? String
         search_tags << criteria[:tags]
       else
         search_tags = criteria[:tags]
       end

       search_tags.each do |tag|
         if tag.end_with?('!')
           match = false if song[:tags].include?( tag.chomp('!') )
         else
           match = false unless song[:tags].include?( tag )
         end
       end

       match
     end
   end

   # Match for artist
   if criteria[:artist]
     results.select! { |song| song[:artist] == criteria[:artist] }
   end

   # Match for custom filter
   if criteria[:filter]
     results.select!(&criteria[:filter])
   end

   results
end
