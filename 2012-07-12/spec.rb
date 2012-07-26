describe 'collection_from_string' do
  let(:additional_tags) do
    {
      'John Coltrane' => %w[saxophone],
      'Bach' => %w[piano polyphone],
    }
  end

  let(:input) do
    <<-END
      My Favourite Things.          John Coltrane.      Jazz, Bebop.        popular, cover
      Greensleves.                  John Coltrane.      Jazz, Bebop.        popular, cover
      Alabama.                      John Coltrane.      Jazz, Avantgarde.   melancholic
      Acknowledgement.              John Coltrane.      Jazz, Avantgarde
      Afro Blue.                    John Coltrane.      Jazz.               melancholic
      'Round Midnight.              John Coltrane.      Jazz
      My Funny Valentine.           Miles Davis.        Jazz.               popular
      Tutu.                         Miles Davis.        Jazz, Fusion.       weird, cool
      Miles Runs the Voodoo Down.   Miles Davis.        Jazz, Fusion.       weird
      Boplicity.                    Miles Davis.        Jazz, Bebop
      Autumn Leaves.                Bill Evans.         Jazz.               popular
      Waltz for Debbie.             Bill Evans.         Jazz
      'Round Midnight.              Thelonious Monk.    Jazz, Bebop
      Ruby, My Dear.                Thelonious Monk.    Jazz.               saxophone
      Hey!.                         Thelonious Monk.    Jazz.               saxophone
      Fur Elise.                    Beethoven.          Classical.          popular
      Moonlight Sonata.             Beethoven.          Classical.          popular
      Pathetique.                   Beethoven.          Classical
      Toccata e Fuga.               Bach.               Classical, Baroque. popular
      Goldberg Variations.          Bach.               Classical, Baroque
      Eine Kleine Nachtmusik.       Mozart.             Classical.          popular, violin
    END
  end

  let(:collection) { collection_from_string input, additional_tags }

  it "returns all entries if called without parameters" do
    songs({}).should have(input.lines.count).items
  end

  it "can look up songs by artist" do
    songs(artist: 'Bill Evans').map { |song_hash| song_hash[:name] }.should =~ ['Autumn Leaves', 'Waltz for Debbie']
  end

  it "doens't modify collection" do
    songs(artist: 'Bill Evans').map { |song_hash| song_hash[:name] }.should =~ ['Autumn Leaves', 'Waltz for Debbie']
    songs({}).should have(input.lines.count).items
  end

  it "can look up songs by name" do
    songs(name: "'Round Midnight").map { |song_hash| song_hash[:artist] }.should =~ ['John Coltrane', 'Thelonious Monk']
  end

  it "song names can end in an exclamation mark" do
    songs(name: "Hey!").map { |song_hash| song_hash[:artist] }.should =~ ['Thelonious Monk']
  end

  it "uses the genre and subgenre as tags" do
    song(name: 'Miles Runs the Voodoo Down')[:tags].should include('jazz', 'fusion')
  end

  it "can find songs by tag" do
    songs(tags: 'baroque').map { |song_hash| song_hash[:name] }.should =~ ['Toccata e Fuga', 'Goldberg Variations']
  end

  it "can find songs by multiple tags" do
    songs(tags: %w[violin popular]).map { |song_hash| song_hash[:name] }.should eq ['Eine Kleine Nachtmusik']
  end

  it "can find songs that don't have a tag" do
    songs(tags: %w[weird cool!]).map { |song_hash| song_hash[:name] }.should eq ['Miles Runs the Voodoo Down']
  end

  it "can filter songs by a lambda" do
    songs(filter: ->(song_hash) { song_hash[:name] == 'Autumn Leaves' }).map { |song_hash| song_hash[:name] }.should eq ['Autumn Leaves']
  end

  it "adds the artist tags to the songs" do
    songs(tags: 'polyphone').map { |song_hash| song_hash[:name] }.should =~ ['Toccata e Fuga', 'Goldberg Variations']
  end

  it "allows multiple criteria" do
    songs(name: "'Round Midnight", tags: 'bebop').map { |song_hash| song_hash[:artist] }.should eq ['Thelonious Monk']
  end

  it "allows all criteria" do
    songs(
      name: "'Round Midnight",
      tags: 'bebop',
      artist: 'Thelonious Monk',
      filter: ->(song_hash) { song_hash[:genre] == 'Jazz' },
    ).map { |song_hash| song_hash[:artist] }.should eq ['Thelonious Monk']
  end

  it "constructs a song hash for each song" do
    song = song(name: 'Tutu')

    song[:name].should      eq 'Tutu'
    song[:artist].should    eq 'Miles Davis'
    song[:genre].should     eq 'Jazz'
    song[:subgenre].should  eq 'Fusion'
    song[:tags].should      include('weird', 'cool')
  end

  def songs(options = {})
    find_in_collection(collection, options)
  end

  def song(options = {})
    songs(options).first
  end
end
