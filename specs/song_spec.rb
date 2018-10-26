require('minitest/autorun')
require('minitest/rg')
require_relative('../song')

class SongTest < Minitest::Test

  def setup

    @song1 = Song.new("Bohemian Rhapsody", "Queen", 355, "Rock", false)
    @song2 = Song.new("With Or Without You", "U2", 296, "Rock", false)
    @song3 = Song.new("Under Pressure", "Queen & David Bowie", 248, "Pop", true)

  end

  def test_song_title
    assert_equal("Bohemian Rhapsody", @song1.title)
  end

  def test_song_artist
    assert_equal("U2", @song2.artist)
  end

  def test_song_length
    assert_equal("5:55", @song1.length)
  end

  def test_song_genre
    assert_equal("Pop", @song3.genre)
  end

  def test_is_song_duo
    assert_equal(true, @song3.duo)
  end

end
