class Message

  def room_reserved
    return "Booking failed: Room is currently reserved"
  end

  def room_full
    return "Booked failed: Room is at capacity"
  end

  def guest_404
    return "Guest not found in this room"
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
