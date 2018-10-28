class Message

  def room_reserved
    return "Booking failed: Room is currently reserved"
  end

  def room_full
    return "Booked failed: Room is at capacity"
  end

  def customer_cant_afford
    return "Customer cant afford this transaction"
  end

  def guest_404
    return "Guest not found in this room"
  end

  def group_cancel
    return "Can't remove single guest from reserved room. Must cancel whole group or unreserve room."
  end

  def room_emptied
    return "Booking cancelled, room emptied entirely"
  end

  def guest_unbooked
    return "Guest successfully unbooked"
  end

  def room_empty
    return "No bookings in room"
  end

  def room_booked
    return "Booking successful for"
  end

  def list_occupants(occupants)
    return occupants.reduce{ |list, guest| list + ", " + guest}
  end

end
