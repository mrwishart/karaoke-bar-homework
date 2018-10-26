require('minitest/autorun')
require('minitest/rg')
require_relative('../guest')

class GuestTest < Minitest::Test

  def setup

    @guest1 = Guest.new("Bob", 25, "Living on a Prayer")
    @guest2 = Guest.new("Frank", 38, "Margaritaville")
    @guest3 = Guest.new("Robert", 56, "Bohemian Rhapsody")

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

end
