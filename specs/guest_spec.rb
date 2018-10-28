require('minitest/autorun')
require('minitest/rg')
require_relative('../guest')

class GuestTest < Minitest::Test

  def setup

    @guest1 = Guest.new("Bob", 25, "Living on a Prayer", 200)
    @guest2 = Guest.new("Frank", 38, "Margaritaville", 300)
    @guest3 = Guest.new("Robert", 56, "Bohemian Rhapsody", 400)

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

end
