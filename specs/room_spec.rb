require('minitest/autorun')
require('minitest/rg')
require_relative('../room')

class RoomTest < MiniTest::Test

  def setup

    @room1 = Room.new("Amazon", 10, 150.00)
    @room2 = Room.new("Nile", 5, 60.00)

  end

  def test_room_name
    assert_equal("Amazon", @room1.name)
    assert_equal("Nile", @room2.name)
  end

  def test_room_capacity
    assert_equal(5, @room2.capacity)
  end

  def test_room_fee
    assert_equal(150.00, @room1.room_fee)
  end

  def test_room_individual_fee
    assert_equal(18.00, @room1.individual_fee)
  end

end
