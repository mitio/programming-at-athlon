describe 'collection_from_string' do
  let(:additional_tags) do
    {}
  end

  let(:input) do
    <<-END
      'Round Midnight.              John Coltrane.      Jazz
      Tutu.                         Miles Davis.        Jazz, Fusion.       weird, cool
      Autumn Leaves.                Bill Evans.         Jazz.               popular
      Waltz for Debbie.             Bill Evans.         Jazz
      'Round Midnight.              Thelonious Monk.    Jazz, Bebop
      Toccata e Fuga.               Bach.               Classical, Baroque. popular
      Goldberg Variations.          Bach.               Classical, Baroque
    END
  end

  let(:collection) { collection_from_string input, additional_tags }

  it "can look up songs by artist" do
    songs(artist: 'Bill Evans').map { |song| song[:name] }.should =~ ['Autumn Leaves', 'Waltz for Debbie']
  end

  it "can look up songs by name" do
    songs(name: "'Round Midnight").map { |song| song[:artist] }.should =~ ['John Coltrane', 'Thelonious Monk']
  end

  it "can find songs by tag" do
    songs(tags: 'baroque').map { |song| song[:name] }.should =~ ['Toccata e Fuga', 'Goldberg Variations']
  end

  it "constructs a song hash for each song" do
    song = find_in_collection(collection, name: 'Tutu').first

    song[:name].should      eq 'Tutu'
    song[:artist].should    eq 'Miles Davis'
    song[:genre].should     eq 'Jazz'
    song[:subgenre].should  eq 'Fusion'
    song[:tags].should      include('weird', 'cool')
  end

  def songs(options = {})
    find_in_collection(collection, options)
  end
end
