require('minitest/autorun')
require('minitest/rg')
require_relative('../room')
require_relative('../guest')
require_relative('../message')

class RoomTest < MiniTest::Test

  def setup

    @testresult = Message.new

    @guest1 = Guest.new("Bob", 25, "Living on a Prayer")
    @guest2 = Guest.new("Frank", 38, "Margaritaville")
    @guest3 = Guest.new("Robert", 56, "Bohemian Rhapsody")

    @room1 = Room.new("Amazon", 10, 150.00)
    @room2 = Room.new("Nile", 5, 60.00)
    @fullroom = Room.new("Zero", 0, 0)
    @booth = Room.new("Booth", 1, 0)

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

  def test_remaining_spaces
    assert_equal(10, @room1.remaining_spaces)
  end

  def test_book_guest_successful
    assert_equal(@testresult.room_booked, @room1.book_guest(@guest1))
    assert_equal(9, @room1.remaining_spaces)
  end

  def test_booked_guest_room_full
    assert_equal(@testresult.room_full, @fullroom.book_guest(@guest1))
    assert_equal(0, @fullroom.remaining_spaces)
  end

  def test_booked_guest_room_full_2

    @booth.book_guest(@guest1)
    #Room should now be full!
    assert_equal(@testresult.room_full, @booth.book_guest(@guest2))
    assert_equal(0, @booth.remaining_spaces)
    assert_equal("Bob", @booth.list_occupants)

  end

  def test_list_of_occupants

    @room1.book_guest(@guest1)
    @room1.book_guest(@guest2)

    assert_equal("Bob, Frank", @room1.list_occupants)

  end

  def test_remove_guest

    @room1.book_guest(@guest1)
    @room1.book_guest(@guest2)

    assert_equal(@testresult.guest_unbooked,@room1.remove_guest(@guest1))
    assert_equal("Frank", @room1.list_occupants)
    assert_equal(9, @room1.remaining_spaces)

  end

end
