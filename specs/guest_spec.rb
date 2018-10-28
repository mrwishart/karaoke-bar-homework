require('minitest/autorun')
require('minitest/rg')
require_relative('../guest')
require_relative('../song')

class GuestTest < Minitest::Test

  def setup

    @guest1 = Guest.new("Bob", 25, "Living on a Prayer", 200)
    @guest2 = Guest.new("Frank", 38, "Margaritaville", 300)
    @guest3 = Guest.new("Robert", 56, "Bohemian Rhapsody", 400)

    @song1 = Song.new("Bohemian Rhapsody", "Queen", 355, "Rock", false)
    @song2 = Song.new("With Or Without You", "U2", 296, "Rock", false)
    @song3 = Song.new("Under Pressure", "Queen & David Bowie", 248, "Pop", true)
    @song4 = Song.new("Living On A Prayer", "Bon Jovi", 251, "Rock", false)

    @allsongs = [@song1, @song2, @song3, @song4]

  end

  def test_guest_name
    assert_equal("Bob", @guest1.name)
  end

  def test_guest_age
    assert_equal(38, @guest2.age)
  end

  def test_guest_song
    assert_equal("Bohemian Rhapsody", @guest3.favourite_song)
  end

  def test_can_afford
    assert_equal(false, @guest1.can_afford?(201))
  end

  def test_pay_money
    @guest1.pay_money(200)
    assert_equal(false, @guest1.can_afford?(1))
  end

  def test_is_favourite_song
    assert_equal(true, @guest3.is_favourite?(@song1))
  end

  def test_check_song
    assert_equal("Meh", @guest1.check_song(@song1))
  end

  def test_check_song__B
    assert_equal("Woo, my favourite!", @guest1.check_song(@song4))
  end

  def test_favourite_in_playlist?
    assert_equal(true, @guest1.favourite_in_playlist?(@allsongs))
  end

  def test_check_playlist
    assert_equal("Woo, it's got my favourite song!", @guest1.check_playlist(@allsongs))
  end

  def test_recieve_money
    assert_equal(false, @guest1.can_afford?(250))
    @guest1.receive_money(50)
    assert_equal(true, @guest1.can_afford?(250))
  end

end
